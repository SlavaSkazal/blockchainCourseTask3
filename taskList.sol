pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract taskList {

    struct task {
        string name;
        uint32 addTime;
        bool done;
    }

    mapping(uint8 => task) taskList;

    uint8 keyTask = 0;

    constructor() public {
        
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        
        tvm.accept();
    }

    function addTask(string name) public returns (uint8) {
     
        keyTask++;
        task newTask = task(name, now, false);
        taskList[keyTask] = newTask;

        tvm.accept();

        return keyTask;
    }

    function getAmountOfOpenTasks() public returns (uint8) {

        uint8 amountOfOpenTasks = 0;

        for ((uint8 key, task value) : taskList) {
            if (!value.done) {
                amountOfOpenTasks++;
            }     
        }

        tvm.accept();

        return amountOfOpenTasks;
    }

    function getTaskList() public returns (mapping(uint8 => task)) {

        tvm.accept();

        return taskList;
    }

    function getDescriptionTaskByKey(uint8 key) public returns (string) {

        tvm.accept();

        if (taskList.exists(key)) {
            return taskList[key].name;    
        } else {
            return "This key does not exist";
        }
    }

    function deleteTaskByKey(uint8 key) public {

        if (taskList.exists(key)) {
            delete taskList[key]; 
        }   

        tvm.accept();  
    }

    function markTaskAsDoneByKey(uint8 key) public {

        if (taskList.exists(key)) {
            taskList[key].done = true; 
        } 

        tvm.accept(); 
    }
}
