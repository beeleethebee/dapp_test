# 1st test of Decentralized Application

I used vue 3 + vite for speed configuration

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

### Using truffle to compile solidity contracts on a ganache server

After opening ganache GUI, link it to `truffle-config.js` and then start 
```sh
truffle migrate 
```

After that, you should be able to use the app. Remember that you need MetaMask and setup
the localhost testnet + account from ganache.