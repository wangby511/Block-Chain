# Block-Chain

$ node -v
>6.9
$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
$ nvm
$ nvm -v
$ nvm install 6.11.3
$ nvm use 6.11.3
$ nvm ls
$ nvm alias default v6

安装truffle框架
$ npm install -g truffle@3.4.9
(-g 全局安装）
$ truffle version
(check)

新建truffle工程：
$ mkdir payroll
$ cd payroll

~payroll 
$ truffle init
$ code (打开VS code）

$ rm -rf *
$ truffle unbox react

$ truffle compile
部署客户端:
$ npm install -g ethereum-testrpc
新建一个terminal：$ testrpc
$ truffle migration
$ npm run start

可以看到localhost:3000上访问网页
./payroll/src/utils/getWeb3.js line 24 :
  var provider = new Web3.providers.HttpProvider('http://127.0.0.1:8545')

做修改
和:
./payrol/truffle.js保持一致:
//file start:

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks:{
    development:{
      host:"127.0.0.1",
      port:8545,
      network_id:"*"
    }
  }
};

//file end.
修改
./payroll/src/App.js line 59:
   return simpleStorageInstance.set(89, {from: accounts[0]})
访问 localhost:3000 可以看到更改的值

The html page shows as follows:

"Good to Go!
Your Truffle Box is installed and ready.

Smart Contract Example
If your contracts compiled and migrated successfully, below will show a stored value of 5 (by default).

Try changing the value stored on line 59 of App.js.
The stored value is: 89"
