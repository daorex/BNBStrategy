### **BNBStrategy ($BSTR)**

#### **What is it?**

BNBStrategy ($BSTR) is a tokenized approach for accumulating BNB, enabling $BSTR holders to claim a portion of a growing BNB pool that is managed through fully transparent, on-chain strategies.

You can think of BNBStrategy as a completely transparent, on-chain version of MicroStrategy. If you are familiar with MicroStrategy's business model, you’ll easily understand the concept.

Note: To optimize efficiency and capture staking yields, BNBStrategy is likely to hold wstBNB instead of regular BNB.

---

### **TL;DR**

1. **Initial Pool:**  
   * The protocol kicks off with a foundational BNB pool funded by early investors.  
   * Initial supporters receive $BSTR tokens, aligning their incentives with the protocol’s expansion.
2. **Growth Strategies:**  
   * **Convertible Bonds:** Users purchase bonds with USDC. The proceeds are used to acquire BNB, enlarging the pool and enhancing the value of $BSTR.  
   * **ATM Offerings:** ATM Offerings: If $BSTR trades at a premium to NAV, new tokens are sold at the market price, with proceeds directed towards acquiring more BNB.  
   * **Redemptions:** Redemptions: If $BSTR trades at a discount to NAV, holders can vote to redeem BNB.

   ---

### **How It Works**

#### **1\. Convertible Bonds (USDC for BNB Acquisition):**

BNBStrategy raises funds by issuing **onchain convertible bonds**, which are structured as follows:

* **Initial Offering:**  
  * Bonds are offered at a fixed price in USDC, with a defined maturity date and strike price in $BSTR.  
* **Conversion Option:**  
  * At maturity, bondholders can convert their bonds into $BSTR tokens if the market price exceeds the strike price.
  * This conversion takes place on-chain, allowing bondholders to benefit from any appreciation in $BSTR’s value.
* **Redemption Option:**  
  * If $BSTR’s market price does not meet the strike price, bondholders can redeem their bonds for the principal in USDC, potentially with a fixed yield.
* **Protocol Benefits:**  
  * The USDC raised is immediately utilized to purchase BNB, expanding the pool and increasing $BSTR’s NAV.
  * This conversion process aligns the interests of bondholders with the protocol's long-term success.

  ---

#### **2\. At-The-Money (ATM) Offerings:**

If $BSTR trades at a **premium to NAV**, BNBStrategy issues new tokens to capture demand and grow the BNB pool.

* **Mechanism:**  
  * New $BSTR tokens are sold at the market price, limited to a certain percentage weekly to protect the interests of existing holders.
  * Proceeds are used to acquire additional BNB for the pool. 
* **Advantages:**  
  * This approach prevents excessive premiums by issuing tokens only when $BSTR is overvalued.
  * It effectively scales the BNB pool, enhancing NAV for all holders.

  

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
