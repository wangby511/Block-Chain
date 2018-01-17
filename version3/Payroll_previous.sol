pragma solidity ^0.4.14;

contract Payroll {
    struct Employee {
        address id;
        uint salary;
        uint lastPayday;
    }
    
    uint constant payDuration = 10 seconds;

    address owner;//0xca35b7d915458ef540ade6068dfe2f44e8fa733c
    mapping (address => Employee) public employees;
    uint totalSalary = 0;
    

    function Payroll() {
        owner = msg.sender;
        
    }
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    modifier employeeExist(address employeeId){
        var employee = employees[employeeId];
        assert(employee.id != 0x0);
        _;
    }
    
    function _partialPaid(Employee employee) private {
        uint payment = employee.salary * (now - employee.lastPayday) / payDuration;
        employee.id.transfer(payment);
    }

    function addEmployee(address employeeId, uint salary) onlyOwner {
        var employee = employees[employeeId];
        assert(employee.id == 0x0);
        employees[employeeId] = Employee(employeeId,salary * 1 ether,now);
        
        totalSalary += salary;
    }
    
    function removeEmployee(address employeeId) onlyOwner employeeExist(employeeId){
        var employee = employees[employeeId];
        
        _partialPaid(employee);
        
        totalSalary -= employees[employeeId].salary;
         delete employees[employeeId];

    }
    
    function updateEmployee(address employeeId, uint newSalary) onlyOwner employeeExist(employeeId){
        var employee = employees[employeeId];
        
        _partialPaid(employee);
        totalSalary = totalSalary - employees[employeeId].salary + newSalary;
        employees[employeeId].salary = newSalary * 1 ether;
        employees[employeeId].lastPayday = now;
    }
    
    function addFund() payable returns (uint) {
        return this.balance;
    }
    
    function calculateRunway() returns (uint) {
        
        return this.balance / totalSalary;
    }
    
    function hasEnoughFund() returns (bool) {
        return this.calculateRunway() > 0;
    }
    
    function checkEmployee(address employeeId) returns (uint salary,uint lastPayday){
        var employee = employees[employeeId];
        salary = employee.salary;
        lastPayday = employee.lastPayday;
        //return (employee.salary,employee.lastPayday);
        
    }
    
    function getPaid() employeeExist(msg.sender) {
         var employee = employees[msg.sender];
         
         uint nextPayday = employee.lastPayday + payDuration;
         assert(nextPayday < now);
         
         employees[msg.sender].lastPayday = nextPayday;
         employee.id.transfer(employee.salary);
    }
}
