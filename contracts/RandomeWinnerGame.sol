// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract RandomWinnerGame is VRFConsumerBase, Ownable {

    //Chainlink variables
    // The amount of LINK to send with the request
    uint256 public fee;
    // ID of public key against which randomness is generated
    bytes32 public keyHash;

    // Address of the players
    address[] public players;
    //Max number of players in one game
    uint8 maxPlayers;
    // Variable to indicate if the game has started or not
    bool public gameStarted;
    // the fees for entering the game
    uint256 entryFee;
    // current game id
    uint256 public gameId;

    // emitted when the game starts
    event GameStarted(uint256 gameId, uint8 maxPlayers, uint256 entryFee);
    // emitted when someone joins a game
    event PlayerJoined(uint256 gameId, address player);
    // emitted when the game ends
    event GameEnded(uint256 gameId, address winner,bytes32 requestId);

   /**
   * constructor inherits a VRFConsumerBase and initiates the values for keyHash, fee and gameStarted
   * @param vrfCoordinator address of VRFCoordinator contract
   * @param linkToken address of LINK token contract
   * @param vrfFee the amount of LINK to send with the request
   * @param vrfKeyHash ID of public key against which randomness is generated
   */
    constructor(address vrfCoordinator, address linkToken,
    bytes32 vrfKeyHash, uint256 vrfFee)
    VRFConsumerBase(vrfCoordinator, linkToken) {
        keyHash = vrfKeyHash;
        fee = vrfFee;
        gameStarted = false;
    }


    function startGame(uint8 _maxPlayers, uint256 _entryFee) public onlyOwner {
    // Check if there is a game already running
    require(!gameStarted, "Game is currently running");
    // empty the players array
    delete players;
    // set the max players for this game
    maxPlayers = _maxPlayers;
    // set the game started to true
    gameStarted = true;
    // setup the entryFee for the game
    entryFee = _entryFee;
    gameId += 1;
    emit GameStarted(gameId, maxPlayers, entryFee);
}


 */
function joinGame() public payable {
    // Check if a game is already running
    require(gameStarted, "Game has not been started yet");
    // Check if the value sent by the user matches the entryFee
    require(msg.value == entryFee, "Value sent is not equal to entryFee");
    // Check if there is still some space left in the game to add another player
    require(players.length < maxPlayers, "Game is full");
    // add the sender to the players list
    players.push(msg.sender);
    emit PlayerJoined(gameId, msg.sender);
    // If the list is full start the winner selection process
    if(players.length == maxPlayers) {
        getRandomWinner();
    }
}
}