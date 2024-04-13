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

Liquidity (L) is the total value of reserves held within a single bin. A bin's liquidity is denominted in the quote asset and represents the combined value of both assets in the bin. Each bin operates as its own constant sum market, meaning that the total value of liquidity within the bin remains constant despite changes in the reserve composition. 

 Price Parameter (𝑃~i~) is a fixed value that represents the exchange rate of the base asset in terms of the quote asset within a particular bin. As the market continuously determines the correct exchange rate for assets, the active trading bin will be whichever bin holds the correct rate.

𝑃~i~ · 𝑥 + 𝑦 = 𝐿

 The price parameter defines a linear relationship graphically where the x-axis represents the reserve of the base asset (X), and the y-axis represents the reserve of the quote asset (Y). As the x and y intercepts change, the slope remains constant as its defined by the price parameter. As you move from one bin to another, the price changes step-wise, and the aggregation of these steps forms the market's liquidity curve across a range of prices. 

**Bin Composition**
Uniswap and most CFMMs utilize the constant product formula (𝑥𝑦=k) for liquidity provisions, this formula remains consistant for the entire price range of the asset. The composition of assets is governed by the formula and therefore the entire price range holds the same asset composition ratio. Since the liquidiy book segregates the price range into bins, each with its own slope, each bin will hold its own asset composition. The unique asset composition for each bin is defined as the bin's composition factor (𝑐).

𝑐 ≡ 𝑦/𝐿  

The composition factor 𝑐 quantifies the proportion of one type of reserve (standardized as asset Y) relative to the total liquidity in a bin. To express the amount of asset Y for a given composition factor we can rewrite the equation as:

𝑦 = 𝑐𝐿  

Here we can see that the amount of asset Y is directly proportional to the bin liquidity multiplied by the composition factor. 

Since 𝐿 is composed of both 𝑥 and 𝑦, the amount of asset X is the amount not expressed by asset Y. 

𝐿 - 𝑦 = 𝐿 − 𝑐𝐿 = 𝐿(1 − 𝑐) 

𝐿(1 − 𝑐) gives us the liquidity reserved for asset X, but still in terms of asset Y. To convert this into an actual quantification of asset X, we must take into account 𝑃~i~, which tells us the amount of Y needed for one unit of X. Therefore, the full equation to quantify the amount of X in a given bin is:

𝑥 = (𝐿(1 − 𝑐))/𝑃~i~

Pragmatically speaking, bins to the left of the active bin will have a 𝑐 of 1, bins to the right of the active bin will have a 𝑐 of 0, and the active bin itself will hold a value between 0 and 1.