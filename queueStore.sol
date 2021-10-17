pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract queueStore {
    
    string[] names;
 
    constructor() public {

        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();
    }

    function getInLine(string name) public {     
        tvm.accept();
        names.push(name);
    }

    function callNext() public {
      
        tvm.accept();

        if (names.length > 0) {
        
            for (uint8 i = 0; i < names.length - 1; i++) {
                names[i] = names[i + 1];
            }

            names.pop();
        }
    }
}
