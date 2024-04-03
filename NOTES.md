# Notes on the [Whitepaper](https://github.com/traderjoe-xyz/LB-Whitepaper/blob/main/Joe%20v2%20Liquidity%20Book%20Whitepaper.pdf)

**Concentrated liquidity**

Uniswap v3 pioneered concentrated liquidity for general AMMs. It allows users to allocate their capital to price ranges of their choosing. 

Users define a starting and ending price point (tick) and their liquidity will be active only when prices fall in their chosen range. All liquidity positions are governed by the same constant product formula (x\*y = k). This allows uniswap v3 to have many individual liquidity positions that can be aggregated together to form a cohesive market. 

Because the relationship between the assets in the pool is governed by a fixed constant formula, LPs have limited flexibility to adjust how their liquidity reacts to different market conditions. Essentially, the price at which trades occur and liquidity is utilized is determined by the formula, not by the LP's individual strategy or market outlook.

**Liquidity Book** 

Instead of user-defined price ranges, the liquidity book arranges liquidity into equal segments of a predefined range (bins). Users then choose which bins they would like to deposit to, enabling LP providers more flexibility in terms of deployment strategies. Here are some of the strategies offered on the UI:

![LP strategies](https://nftstorage.link/ipfs/bafkreihlnbygycidf7jxjx35xnbels4d2os52jhh3m4y5xzwi5egbetkl4)

Each bin essentially has its own price range in which it operates. Bins also follow a constant sum model instead of the traditional constant product (more on this in following sections). This means that assets within a bin maintain a linear relationship to each other 

The cohesion of the market comes from aggregating the liquidity across all these discrete bins. While each bin can operate independently with its unique price range and linear relationship between assets, when a trade occurs, the protocol can move through these bins to execute trades, effectively pooling the liquidity from various bins as needed. For a trade that requires more liquidity than available in a single bin, the liquidity book automatically engages adjacent bins in the trade.

**Reserve Pricing**

Price in a trading pair is calculated as the ratio of the change in the quantity of the quote asset (Y) to the change in the quantity of the base asset (X), where pairs are denoted as "Base Asset/Quote Asset"

P = ∆y/∆x

For example, in the pair BTC/ETH:

- base: BTC
- quote: ETH

The amount of ETH needed to buy one BTC  = The change in quantity of ETH in reserves / the change of quantity of BTC in reserves

**Bin Liquidity**

Liquidity (L) is the total value of reserves held within a single bin. A bin's liquidity is denominted in the quote asset and represents the combined value of both assets in the bin.

Each bin operates as its own constant sum market, meaning that the total value of liquidity within the bin remains constant despite changes in the reserve composition. Price Parameter (𝑃~𝑖~) is a fixed value that represents the exchange rate of the base asset in terms of the quote asset within a particular bin.

𝑃~𝑖~ · 𝑥 + 𝑦 = 𝐿

 The price parameter defines a linear relationship on a graph where the x-axis represents the reserve of the base asset (X), and the y-axis represents the reserve of the quote asset (Y) and the slope is the price parameter.

