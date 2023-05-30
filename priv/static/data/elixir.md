# Old is the new modern

#### author: Filip Vavera

<a target="_blank" rel="noopener noreferrer" href="https://youtu.be/17e9MUDrrnc">link to talk on YouTube (CZ)</a>

note:
zdravim vsechny, jsem Filip Vavera a pracuju jako Software Architekt ve firme
CrazyEgg.

S Elixirem jsem se poprve seznamil v roce 2018 a od te doby jsem ho neopustil

---

## BEAM languages

- Erlang
- Elixir
- LFE
- Alpaca
- Gleam
- ...

note:
tematem teto prednasky je Elixir a to predevsim funkcionalita, kterou nam poskytuje Er

I pres ruzne rozdily mezi temito jazyky v teto prednasce o nich budu mluvit
zamenitelne, tzn. pokud reknu Elixir, muzete si za to dosadit jakykoliv jiny
jazyk jako by to byl pouze jiny interface pro komunikovani s BEAM a realizovani
jeho potencialu. Vsechny moje priklady budou v Elixiru a ja osobne pracuju s
Elixirem, takze budu mluvit o Elixiru, ale klidne si za to dosazujte Erlang nebo
nejaky jiny BEAM jazyk.

Moje prednaska se bude skladat ze 2 casti, nejdrive si ukazeme, jak BEAM resi
paralelizaci, ve druhe, hlavni casti, si ukazeme, co to znamena v praxi a jak se
takovy system chova. Ukazeme si jak rozdelit system na procesy a pobavime se o
tom proc jsem zvolil tento pristup a jake benefity nam prinasi.

---

## BEAM concurrency

note:
Tak se bez dalsiho zdrzovani pojdme vrhnout na BEAM paralelizaci a hlavni
koncept o kterem se budeme bavit je process


### Process

```elixir [2]
...
do_something(...)
...
```
<!-- .element: class="fragment fade-in-then-out" -->

```elixir [2]
...
spawn(fn -> ... end)
...
```
<!-- .element: class="fragment" -->

note:
Jakykoliv Elixir kod bezi v nejakem procesu. Pro upresneni, proces o kterem budu
mluvit neni systemovy proces ani systemove vlakno. Uplne zjednodusene proces je
sekvencni program, tedy program, ktery neobsahuje zadnou interni paralelizaci.
A dokud je sekvencni tak o Elixiru mluvime jako o funkcinalnim jazyku

Pak tady ale mame uplne jine paradigma v tom stejnem jazyce a to je paralelni
Elixir. Aby jazyk mohl byt paralelizovany, musi byt schopen bezet zaroven vice
procesu. Je nekolik zpusobu jak toho v Elixiru dosahnout, ale ten nejzakladnejsi
vypada nejak takto

Kdy pomoci funkce `spawn` ze standardni knihovny muzeme spustit novy proces z
aktualniho procesu. Od teto chvile mame v nasem systemu dva procesy, ktere bezi
paralelne vedle sebe.


<div class="two-column">
  <div>
    <h4>process A</h4>
    <pre><code>
...
foo(...)
bar(...)
...
    </code></pre>
  </div>
  <div>
    <h4>process B</h4>
    <pre><code>
...
baz(...)
qux(...)
...
    </code></pre>
  </div>
</div>

note:
nebo take muzeme rict, ze mame dva, kompletne nezavisle programy, ktere bezi
naprosto oddelene a nemaji spolu nic spolecneho, maji vlastni oddelenou pamet,
stack, heap a maji svuj vlastni nezavisly garbage collector

jediny zpusob jak tyto dva programy spolu muzou spolupracovat je tak, ze si
budou posilat zpravy


<div class="two-column">
  <div>
    <h4>process A</h4>
    <pre><code>
send(process_b, some_message)
    </code></pre>
  </div>
  <div>
    <h4>process B</h4>
    <pre><code>
receive do
  msg -> handle_message(msg)
end
    </code></pre>
  </div>
</div>

note:
v Elixiru je nekolik ruznych zpusobu jak to udelat ale ten nejzakladnejsi je
funkce `send` ze standardni knihovny pomoci ktere muzeme poslat zpravu jinemu
procesu. Zprava muzou byt jakekoliv data, jakakoliv datova struktura se kterou
Elixir umi pracovat.

A na strane procesu, ktery prijima zpravu pomoci `receive` funkce dostaneme
jednu zpravu ze message mailbox procesu, coz je neco jako FIFO fronta.

Abyste si to lepe predstavili, muzete si to predstavit jako mikroservices.
Microservices jsou uplne oddelene programy, typicky dva systemove procesy, ktere
nemaji nic spolecneho a aby mohli spolupracovat, musi si nejakym zpusobem
posilat zpravy, typicky nejakym HTTP requestem

V Elixiru je to velmi podobne, az na to ze zpravy se neposilaji pres sit,
nepotrebujete HTTP protokol, serializaci, deserializaci, atd. vsechno je nativne
podporovane za behu programu


### BEAM structure

- one OS process <!-- .element: class="fragment" -->
- many BEAM processes <!-- .element: class="fragment" -->
- one scheduler per CPU core <!-- .element: class="fragment" -->

note:
Jak tedy vypada bezici Erlang Virtual Machine? Ve chvili kdy spustite BEAM
nastartuje se jediny systemovy proces uvnitr tohoto procesu bude spoustu malych
sekvencnich programu - Erlang procesu. A bude jich tam fakt hodne, desitky tisic
az miliony procesu. Hard limit je neco pres 130 milionu na jednu instanci BEAM

Dale tam bude bezet nekolik systemovych vlaken, kterym se rika scheduler a ktere
jsou zodpovedne za exekuci techto jednoduchych programu - procesu. Ve vychozim
nastaveni jich bude bezet tolik kolik ma BEAM k dispozici CPU jader. Muzete si
to predstavit jako jednu velkou frontu procesu, ze ktere si scheduler vezme
prvni, chvili ho necha pracovat, pak ho zaradi na konec fronty a vezme dalsi
proces

A to je vsechno! Jednoduche, ze? Vyvstava ted ale otazka co s tim? Jak to pouzit
v realne aplikaci? Jak nas system rozdelit na samostatne procesy?

---

## Concurrency in practice

note:
Za timto ucelem jsem si pripravil nekolik demonstraci. Aktualne mi na pocitaci
bezi BEAM node s aplikaci, kterou vam za chvili predstavim. Bezi to uplne
stejne, jako bych tuto aplikaci spustil na produkcnim serveru, jen jsem umele
prepsal pocet scheduleru na 1 misto defaultnich 8 protoze to bude demonstrovat
urcite vlastnosti tohoto systemu

load demo on http://localhost:4000/load

app demo on http://localhost:4000/


```text
                              client
                                 ^
                                 |
                                 |
                                 |
                                 v
                              system
```

note:
kdyz uzivatel navstivi jakoukoliv stranku tohoto systemu, mezi browserem a
serverem se navaze websocket connection a veskera komunikace mezi serverem a
browserem nadale probiha pouze skrze tuto websocket connection


```text
                              client
                     sum(1..3) |  ^
                               |  |
                               |  |
                               |  |
                               v  | 6
                              system
```

note:
browser tedy pres websocket posle request "dej mi soucet prvnich 3 prirozenych
cisel, system tento pozadavek zpracuje a posle vysledek asynchrone skrze
websocket connection a tento vysledek je browserem vyrendrovany


```text
              client          client          client
                 ^               ^               ^
                 |               |               |
                 |               |               |
                 |               |               |
                 v               v               v
            connection      connection      connection
```

note:
co se tyce struktury procesu uvnitr BEAM tak kazda WebSocket connection je
spravovana jednim procesem, takze kazdy frontend uzivatel ma svuj vlastni proces
na serveru, ktery stara o jeho instanci. Techto procesu bude tolik, kolik
aktualne mame aktivnich uzivatelu. Muze to byt milion, muze to byt 0. Jsou
dynamicky vytvarene a ukonci se ve chvili, kdy uzivatel ukonci websocket
connection


```text
                            connection
                        spawn |    ^
                              |    |
                              |    |
                              |    |
                              v    |  send result & stop
                            calculation
```

note:
v ramci jednoho connection procesu se ale deje zajimava vec, protoze samotna
kalkulace sumy se deje ve svem vlastnim, separatnim procesu. Takze kdyz poslu
request "dej mi sumu nejakeho prirozeneho cisla" connection proces spusti dalsi
proces coz bude calculation proces, kde je vypocitan samotny vysledek.
Calculation proces pak posle vysledek connection procesu, ktery jej posle pres
WebSocket do browseru a calculation proces je ale mezitim ukoncen

Otazka samozrejme je, proc zrovna tahle struktura procesu, urcite jsem ji
nevybral nahodne. Duvod proc jsem zvolil tuto strukturu procesu je abych
vylepsil odolnost systemu proti chybam a aby byl system pristupny a rychly i ve
chvili, kdy jsou pritomny nejake problemy

#### bug with 13

I kdyz nam exekuce kodu v jednom procesu crashne, nema to zadny vliv na zbytek
systemu. Rozdelenim kodu na procesy muzeme take oddelit chyby a vyjimky

#### latency bug 999_999_999

BEAM schedulery provadi velmi rychle prepinani mezi procesy, cimz umoznuji aby
jeden proces, nevzal cely vypocetni vykon. BEAM je napsany tak, ze preferuje
aby cely system bezel neustale vpred relativne stabilne, na ukor maximalni
efektivity jednotlivych procesu. Proto Elixir nebo Erlang nikdy nejsou na
prednich prickach rychlosti webovych serveru, protoze tuto maximalni efektivitu
obetuji ve prospech plynuleho chodu celeho systemyu. Tento system nam umozni
oddelit latency jednotlivych procesu.

#### invalid input -1

tento bug zpusobi, ze proces nikdy nevrati zadnou hodnotu, ale bude v nekonecne
smycce pocitat. Zbytek systemu stale bezi podle ocekavani, ale je zjevne ze
tento se sam nevyresi a bude vyzadovat nasi manualni intervenci.

Nastesti BEAM ma skvele nastroje pro to, jak jej debugovat v produkci, bez toho
abychom museli system zastavit nebo jakkoliv ovlivnit jeho dostupnost pro nase
uzivatele. Pojdme se tedy podivat jak to udelat:

```elixir
# look at logs, nothing interesting
_build/prod/rel/system/bin/system remote_console
1 + 3
Process.list()
Process.info(hd(Process.list())) # reductions (instructions executed)
Runtime.top()
pid = hd(Runtime.top()).pid
Process.info(pid, :current_stacktrace)
Runtime.trace(pid)
Process.exit(pid, :kill)
```

fix code

```
mix test
mix system.upgrade
```

```
mix system.node2
```

---

## Questions

---

## Contact

[sgiath.dev](https://sgiath.dev)

[FilipVavera@sgiath.dev](mailto:FilipVavera@sgiath.dev)
