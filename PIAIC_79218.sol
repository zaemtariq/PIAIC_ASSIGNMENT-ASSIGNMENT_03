pragma solidity ^0.8.0;

contract PIAICBCCToken{
    //mapping to hold balances against EOA accounts
    mapping (address => uint256) private _balances;


    //the amount of tokens in existence
    uint256 private _totalSupply;

    //owner
    address public owner;
    
    string public name;
    string public symbol;
    uint public decimals;
    
    uint public tokenPrice_per_ether;
    constructor () public {
        name = "Zaeem Tariq";
        symbol = "PIAIC79218";
        decimals = 18;  //1  - 1000 PKR 1 = 100 Paisa 2 decimal
        owner = msg.sender;
        tokenPrice_per_ether=100;
        
        _totalSupply = 1000000 * 10**decimals;     //1 million tokens to be generated
        
        _balances[owner] = _totalSupply;  //transfer total supply to owner
       
     }
     
     
       modifier onlyOwner {
        require(msg.sender == owner,"Only Owner can do this task.");
        _;
    }
     
     
       modifier notOwner {
        require(msg.sender != owner,"Your already Owner u can  not do this task.");
        _;
    }
     
     
    
     
    function totalSupply() public view  returns (uint256) {
        return _totalSupply;
    }


    function setTokenPrice(uint256 Token_price_per_Ether) public onlyOwner{
        tokenPrice_per_ether = Token_price_per_Ether;
        }


    function buy_Token() external payable notOwner{
        require(msg.value >= 1 ether, "NOT SUFFICIENT BALANCE.");
        (payable(owner)).transfer(msg.value);
        _balances[owner] =_balances[owner] - tokenPrice_per_ether * (msg.value/(10**decimals) );
        _balances[msg.sender] = _balances[msg.sender] + tokenPrice_per_ether * (msg.value/(10**decimals));
    }


    function check_token_balance() view public onlyOwner returns(uint) {
    return _balances[owner];
    }
    

}
