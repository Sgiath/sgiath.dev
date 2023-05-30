# Introduction to Bitcoin

#### author: Filip Vavera

<a target="_blank" rel="noopener noreferrer" href="https://youtu.be/MptNhehwLxE?t=1255s">link to talk on YouTube (CZ)</a>

---

## Case for Bitcoin

note:
So first of all I will try to explain why is Bitcoin interesting and why am I
convinced that it will eventually win


### Why do we need money

Price signals and economic calculation <!-- .element: class="fragment" -->

note:
I'm going to refer to Bitcoin as money. But first of all, we have to answer
the question of what is money and what do we need it for? These questions have many
answers, but for now we're going to be interested in these two in particular:
economic calculation and price signals. From this perspective, money is a unique
tool that allows us to communicate information that is otherwise very difficult
to communicate. Let me put it this way with two brief examples

Example 1:

There will be flooding in Argentina, which will cause a problem with lithium
mining, resulting in less lithium on the market, which will lead to an increase
in its price. What are the implications of this?

1. for people who know how to source lithium, it is a signal that they should start
   mining lithium, because lithium is now expensive and there is good money to be
   made. That way, they can get lithium back on the market after a while.
2. it is a signal to people who use lithium that they should cut back on it or look
   for substitutes
3. only those who really need lithium, i.e. those who are willing to pay the higher
   price, will get access to the existing lithium

And it is important to note that the local flood in Argentina is not at all obvious,
that the correct response for me is to start cutting back on lithium batteries...
without money and lithium price increases, the remaining lithium would be wasted on
useless batteries and then it would really miss where it's needed. None of the people
I described above didn't need to follow the news about what was going on in Argentina,
but they were able to to adapt effectively to the situation because of money and its
price signals.

Example 2:

I have a pile of wood and I have to decide whether it is more efficient to build
a bridge, a house, a pile of furniture or to use it as fuel.

Without prices, it's basically impossible to determine which is the better and more
efficient use, each has its pros and cons, which cannot be compared well enough.
I can help many people a little, a few people a lot.

But if we look at what people are willing to pay us for, it's easy we can see which
product is the most effective.


### Why harder money always win

What is wrong with current money? <!-- .element: class="fragment" -->

[WTF happened in 1971.com](https://wtfhappenedin1971.com/) <!-- .element: class="fragment" -->

note:
Now that we know why we need money, let's see what kind of money is actually used
and why. I will start with a few examples:

Among the prisoners, cigarettes are most often used as money. Why? Because no one
in prison can make cigarettes, so cigarettes are expensive and not easy to get to get
hold of them and so they end up as "money".

Historically, in places where, for example, mules were not available, they used these
societies used muesli as currency, or in West Africa where they didn't have the
technology to make glass, the pieces of glass that were imported from elsewhere were
very valuable and people started using them as money.

And then, of course, gold, which gradually became the money of the whole the planet
by the end of the 19th century, because the gold supply is the slowest of all
the precious metals. Even though every year we mine new gold and we keep improving
the efficiency of its mining, what we mine is only a small fraction of our existing
gold supply. The gold stock is growing at about 1.5 to 2% per year.

This makes gold money, gold was not used as money because it is yellow, or because it is
shiny or because it's pretty, but because it's the hardest thing to increase its supply.
By the way, silver is a close second, but silver can corrode and there's a lot more
of it on earth than there is gold, so historically the supply has been increasing by
5-10% a year.

But then, of course, in the 20th century we dealt, or rather politicians dealt a major
blow to our civilization project. Because money, which is difficult to earn and retains
its value for the future, is not quite suited for financing political plans and especially
wars. Therefore we see that many countries abandoned the gold standard during World War I
and at the end of World War II virtually the only country on the gold standard were
the United States. But they also abandoned it in 1971. These countries then forced people
to use government paper money, which can be produced in much in much larger quantities
and much cheaper than gold by the government.

You can see how this has affected the economy in the charts on the future page called
"what the fuck happened in 1971", I'll just say it had a massive destructive effects
on society because we lost the ability to save and with that we've lost our ability
to think about the future and we're more oriented towards present. You can see these
effects in various aspects of life throughout 20th century.


### Why is Bitcoin the hardest money we know

note:
But what does this have to do with Bitcoin, you might ask? An important aspect of gold, that
has enabled the states to push their paper money, is that gold is physical and the moment
the world became more and more interconnected, gold trading became more and more more
dependent on banks, because to send a boatload of gold to the other side of the world is
quite a problem, which then governments made their central banks and then gold trading
became dependent on state permission.

And this is where Bitcoin comes into play, allowing us to circumvent this problem and
allows us to have the value of gold, the ease of portability both in time and in space,
that is not dependent on states and banks, allowing us to preserve effective value into
the future.

But how does Bitcoin do this? How can digital data be valuable if we can always make a free
copy? Let's take a look:

---

## Explain it like I am 5

note:
So let's explain how Bitcoin technically works, how we would explain to a five-year-old


### Excel sheet with transactions

notes:
You can imagine Bitcoin as a huge Excel spreadsheet, where every row is a single
transaction - that is, from what address to what address and what quantity Bitcoin is sent.
Everyone copies this spreadsheet between themselves and adds new transactions, so when
we look at all the transactions for a particular address it's easy to determine how much
is left at that address. Now imagine that these transactions are not all in one table,
but are organized into individual sheets. Each sheet has a maximum size and about every
10 minutes a new sheet with transactions is added.

But how to make sure that someone will not send another fake version of this Excel sheet?
Or better said, how to agree on the one, real version?

And how to ensure that only the real owner of the address can spend the bitcoins from
the address?

In order to explain this, I first need to explain two concepts in cryptography - hashing
and asymmetric encryption


### Hashing

Hash lottery

notes:
A hashing algorithm is a special type of algorithm that accepts any input and produces a
deterministic output that satisfies these properties:

- a small change in the input causes a large change in the output
- for a given input, it is not possible to estimate the output faster than running a hash
  algorithm
- cannot algorithmically calculate the necessary input for a given output - fastest is to
  try random inputs until you hit the output

The main role of the hashing algorithm in Bitcoin is in proof-of-work when anyone who
wants to add a new Excel page with transactions has to construct it in such a way that
the hashing algorithm produces a certain value, which is computationally intensive
because the only way to find out is to try millions of different variations of the table
to prove to everyone else that I've done some proof-of-work.

And then everyone can agree that the one, true version is the one that has the most
proof-of-work.


### Asymmetric encryption

Signing transactions

notes:
Asymmetric encryption is a special type of encryption that uses two keys instead of one.
With the help of a private key I can generate a unique signature of any data and
the validity of this signature can then be verified using the public key with which but
this signature cannot be produced

Bitcoin is used in the following way: the moment I want to receive bitcoin to my address,
I publish my public key and whoever wants to send me bitcoins creates a transaction that
says "these bitcoins can be spent by anyone who can create a signature that can be verified
by this public key. If I then want make a transaction with these "my" bitcoins, I'll create
a new transaction and sign it with my private key, and only then will it be valid and anyone
who makes that transaction can easily verify it, because I have published my public key.

And that's it, this is Bitcoin for five-year-olds. But let's see a little bit a little
closer at what technologies bitcoin works with

---

## Anatomy of blockchain

![](https://developer.bitcoin.org/_images/en-blockchain-overview.svg)

note:
Probably everyone who doesn't live in a cave has heard the word blockchain in recent years.
So what is it? As the name suggests, it's a blockchain. A block is a single Excel sheet
with the transactions from our example. And why is it a chain? Because each block contains
a "hash" of its predecessor block. Which has one important property, namely that if I want
to change the content of a block, the hash of that block will change, but since the hash
is included in the next block, I have to change the hash there too, which will change
the hash of the next block, etc. etc.

So the blockchain contains the entire history of Bitcoin, all the transactions that have
ever been made. It's currently around 500GB.

So if I want to change some transactions in the past, I need to change and recalculate
the hash of the block the transaction is in and all subsequent blocks up to the present.
And I have to do more work than everybody else to find the blocks that follow
the changed block. Which makes any any editing of the past becomes virtually impossible.

This is the main reason for the existence of proof-of-work. Some call it redundant
firing electricity, which is only useless if you don't care about safety of your money.
The work involved in finding the right blocks is the price you pay we pay for the security
of Bitcoin.


### How are new BTC created

![](/images/bitcoin_monetary_policy.jpg)

note:
And a brief word about how new Bitcoins are created: in each new block there is a special
transaction called "coinbase", this transaction contains the new created Bitcoins that
did not come from any other address + the fees of the transactions included in that block

At the beginning each new block created 50 bitcoins, but this value is halved every
210_000 blocks (which is about 4 years), so in 2013 it was 25 BTC per block,
2017 12.5 BTC per block and this year the reward has been reduced to 6.25 BTC per block.
This will continue until about 2140 when the last Bitcoin will be mined and the following
blocks will be sponsored only by transaction fees

Thanks to this, we can easily calculate how many Bitcoins will ever exist using the formula
you see on the slide - there will never be more than 21 million Bitcoins.

---

## Anatomy of transaction

- UTXO - Unspent Transaction Output <!-- .element: class="fragment" -->
- Different kind of transations - P2PK, P2PKH, P2SH, P2WPKH, P2TR <!-- .element: class="fragment" -->

notes:
Now let's see what such a transaction looks like.

Each transaction has one or more inputs and one or more outputs. Each input is an output
of some other transaction, and each output can be an input of some other transaction,
or it can be unspent. This is called "unspent transaction output", abbreviated UTXO.

We also have several transaction types. I list their abbreviations here, as it's
something you'll come across a lot.


![](https://developer.bitcoin.org/_images/en-transaction-propagation.svg)

note:
And here we can look at a model of what I described


### P2PKH - Pay to Public Key Hash transaction

![](https://developer.bitcoin.org/_images/en-unlocking-p2pkh-output.svg)

note:
And here is a description of what a "pay to public key hash" transaction looks like.
The transaction contains a signature script that contains all the information needed
to verify the signature of the transaction. First, it contains the hash of the UTXO
we want to spend - which is in practice the hash of our public key. Next, it contains
the entire public key (so we can verify that the hash really matches) and finally it
contains the private key signature, which we can verify using the published public key.


### Mempool

note:
Mempool is a designation for transactions that have not yet been confirmed and included
in of a block. These are all transactions that someone has created, posted and thus
expressed a desire to perform them, but which have not yet been included in any block.

---

## Wallets and Full Nodes


### Wallet as glorified file storage
We need to store private key for each address we use

Of course wallets do much more than that <!-- .element: class="fragment" -->


### BIP32 - key derivation
We need to store just one private key from which we can later derive our other
private keys


### BIP39 - mnemonic words
We can express bits of private key as 12 or 24 English words so we need to store
just them


### Don't trust, verify
What full node does?

---

## What next?


### Layer 2 and 3
Lightning Network


### Taproot

Different, better way of constructing and storing transactions resolved by
script


### Schnorr Signatures

Different, better, way of signing transactions

---

## Questions


### Link aggreggates

- <a target="_blank" rel="noopener noreferrer" href="https://www.lopp.net/bitcoin-information.html">loop.net</a>
- <a target="_blank" rel="noopener noreferrer" href="https://bitcoin.ninja/">bitcoin.ninja</a>


### Explanation

- <a target="_blank" rel="noopener noreferrer" href="https://braiins.com/blog/bitcoinove-penize">Bitcoinové peníze (CZ, kids)</a>
- <a target="_blank" rel="noopener noreferrer" href="https://braiins.com/blog/vynalez-jmenem-bitcoin">Vynález jménem Bitcoin (CZ)</a>
- <a target="_blank" rel="noopener noreferrer" href="https://www.bitcoinsimulator.tk/explanation">Bitcoin Simulator</a>
- <a target="_blank" rel="noopener noreferrer" href="https://michaelnielsen.org/ddi/how-the-bitcoin-protocol-actually-works/">How the Bitcoin protocol actually works</a>
- <a target="_blank" rel="noopener noreferrer" href="https://github.com/BlockchainCommons/Learning-Bitcoin-from-the-Command-Line">Learn Bitcoin from Command Line</a>
- <a target="_blank" rel="noopener noreferrer" href="https://www.righto.com/2014/02/bitcoins-hard-way-using-raw-bitcoin.html">Bitcoin: the hard way</a>
- <a target="_blank" rel="noopener noreferrer" href="https://www.samlewis.me/2017/06/a-peek-under-bitcoins-hood/">A peek under Bitcoin hood</a>
- <a target="_blank" rel="noopener noreferrer" href="https://chaincode.gitbook.io/seminars/">Bitcoin seminars</a>


### Developer resources

- <a target="_blank" rel="noopener noreferrer" href="https://developer.bitcoin.org">bitcoin.org</a>
- <a target="_blank" rel="noopener noreferrer" href="https://davidederosa.com/basic-blockchain-programming/">Basic blockchain programming</a>
- <a target="_blank" rel="noopener noreferrer" href="https://www.youtube.com/playlist?list=PLmL13yqb6OxdEgSoua2WuqHKBuIqvll0x">Blockchain tutorial</a>


### History

- <a target="_blank" rel="noopener noreferrer" href="https://medium.com/coinmonks/exploring-bitcoins-history-ecbf1c59952c">Exploring Bitcoin’s History</a>
- <a target="_blank" rel="noopener noreferrer" href="https://www.lopp.net/bitcoin-information/history.html">loop.net</a>
- <a target="_blank" rel="noopener noreferrer" href="http://www.hashcash.org/">Hashcash</a>


### Economy Books

- <a target="_blank" rel="noopener noreferrer" href="https://saifedean.com/thebitcoinstandard/">The Bitcoin Standard</a>
- <a target="_blank" rel="noopener noreferrer" href="https://mises.org/library/human-action-0">Human Action</a>
- <a target="_blank" rel="noopener noreferrer" href="https://braiins.com/blog/odluka-penez-od-statu-kniha-josef-tetek">Bitcoin: Odluka peněz od státu (CZ)</a>


### Economy Podcasts

- <a target="_blank" rel="noopener noreferrer" href="https://www.youtube.com/playlist?list=PLGJQS0h-wqLQqIZ6U6gn5jsaUsjUqi1Bt">Nestátní peníze (CZ)</a>


### Belletry

- Bitcoin Astronomy
   - <a target="_blank" rel="noopener noreferrer" href="https://unchained.com/blog/law-of-hash-horizons/">Part 1: The Law of Hash Horizons</a>
   - <a target="_blank" rel="noopener noreferrer" href="https://unchained.com/blog/bitcoin-astronomy-part-ii/">Part 2: The Hash Exclusion Principle</a>
   - <a target="_blank" rel="noopener noreferrer" href="https://unchained.com/blog/bitcoin-astronomy-part-iii/">Part 3: The Law of Hash Universality</a>


### Interesting Twitter accounts


### Bitcoin

- <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/0xB10C">b10c</a>
- <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/adam3us">Adam Back</a>
- <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/saifedean">Saifedean</a>
- <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/TheVladCostea">Vlad Costea</a>
- <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/dergigi">Gigi</a>
- <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/DocumentingBTC">Documenting Bitcoin</a>
- <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/SatsJoseph">Josef Tetek</a>


### Economy

- <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/steida">Daniel Steigerwald (CZ)</a>
- <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/Stroukal">Dominik Stroukal (CZ)</a>
- <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/JurajKarpis">Juraj Karpis (SK)</a>

---

## Contact

[sgiath.dev](https://sgiath.dev)

[FilipVavera@sgiath.dev](mailto:FilipVavera@sgiath.dev)
