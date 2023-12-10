// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./MyERC721.sol";
import "./PriceFeed.sol";

contract ArtSprint is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Project {
        uint256 projectId;
        address projectCreator;
        string description;
        uint timelineForCollectionInDays;
        uint256 startDate;
        uint256 amountToBeCollectedInEther;
        uint256 fundsCollected;
    }

    struct InvestmentDetail {
        uint projectID;
        address investorAddress;
        uint investedAmount;
    }

    Project[] public projects;
    InvestmentDetail[] public investmentDetails;
    uint[] public arrayToStoreIndex = new uint[](0);
    uint256 public projectCount = 0;

    MyERC721 private _myERC721;
    PriceFeed private _priceFeed;

    constructor(address myERC721Address, address priceFeedAddress) ERC721("ArtSprint", "AS") {
        _myERC721 = MyERC721(myERC721Address);
        _priceFeed = PriceFeed(priceFeedAddress);
    }
   


    

/////////////////////////////////////////////////////////////////////////////////////////////////////

     // Function to create a new project
    function createProject(
        string memory _description, 
        uint _timelineForCollectionInDays, 
        uint256 _amountToBeCollectedInEther
    ) public {
        projectCount++; // Increment the project count for a new ID
        // Create a new project and add it to the creator's project list
        Project storage newProject = projects.push();
        // Initialize the new project with provided details
        newProject.projectId = projectCount;
        newProject.projectCreator = msg.sender;
        newProject.description = _description;
        newProject.timelineForCollectionInDays = _timelineForCollectionInDays;
        newProject.startDate = block.timestamp;
        newProject.amountToBeCollectedInEther = _amountToBeCollectedInEther;
        newProject.fundsCollected = 0;

    }

/////////////////////////////////////////////////////////////////////////////////////////////////////

    // Function to get project details by creator's address
    function getMyCreatedProjects() public view returns (Project[] memory) {
        uint createdProjectCount = 0;

        // Count the number of projects created by the sender
        for (uint i = 0; i < projects.length; i++) {
            if (projects[i].projectCreator == msg.sender) {
                createdProjectCount++;
            }
        }

        // Create an array to store projects created by the sender
        Project[] memory creatorProjects = new Project[](createdProjectCount);
        uint currentIndex = 0;

        // Populate the array with project details
        for (uint i = 0; i < projects.length; i++) {
            if (projects[i].projectCreator == msg.sender) {
                creatorProjects[currentIndex] = projects[i];
                currentIndex++;
            }
        }

        return creatorProjects;
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Function to get all active projects
    function getAllActiveProjects() public view returns (
        uint256[] memory, 
        address[] memory, 
        string[] memory, 
        uint[] memory, 
        uint256[] memory, 
        uint256[] memory, 
        uint256[] memory
    ) {
        uint256 activeProjectCount = 0;

        // First, count the number of active projects
        for (uint256 i = 0; i < projects.length; i++) {
            if (isProjectActive(projects[i])) {
                activeProjectCount++;
            }
        }

        // Create arrays to store the details of active projects
        uint256[] memory projectIds = new uint256[](activeProjectCount);
        address[] memory projectCreators = new address[](activeProjectCount);
        string[] memory descriptions = new string[](activeProjectCount);
        uint[] memory timelines = new uint[](activeProjectCount);
        uint256[] memory startDates = new uint256[](activeProjectCount);
        uint256[] memory amountsToBeCollected = new uint256[](activeProjectCount);
        uint256[] memory fundsCollected = new uint256[](activeProjectCount);

        uint256 currentIndex = 0;

        // Populate the arrays with details of active projects
        for (uint256 i = 0; i < projects.length; i++) {
            if (isProjectActive(projects[i])) {
                projectIds[currentIndex] = projects[i].projectId;
                projectCreators[currentIndex] = projects[i].projectCreator;
                descriptions[currentIndex] = projects[i].description;
                timelines[currentIndex] = projects[i].timelineForCollectionInDays;
                startDates[currentIndex] = projects[i].startDate;
                amountsToBeCollected[currentIndex] = projects[i].amountToBeCollectedInEther;
                fundsCollected[currentIndex] = projects[i].fundsCollected;

                currentIndex++;
            }
        }

        return (
            projectIds, 
            projectCreators, 
            descriptions, 
            timelines, 
            startDates, 
            amountsToBeCollected, 
            fundsCollected
        );
    }

    // Helper function to check if a project is active
    function isProjectActive(Project storage project) internal view returns (bool) {
        return project.fundsCollected < project.amountToBeCollectedInEther &&
               block.timestamp <= project.startDate + (project.timelineForCollectionInDays * 1 days);
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////

    // Function to invest in a project
    function investInProject(uint index) public payable {
        require(index < projectCount, "Invalid project index");
        Project storage project = projects[index];

        //require(block.timestamp <= project.startDate + (project.timelineForCollectionInDays * 1 days), "Project funding period has ended");
        //require(project.fundsCollected < project.amountToBeCollectedInEther, "Project has reached its funding goal");

        project.fundsCollected += msg.value;
        //project.investorContributions[msg.sender] += msg.value;

        // Transfer Ether to project creator
        payable(project.projectCreator).transfer(msg.value);

        // Record the investment details
        InvestmentDetail storage newInvestmentDetail = investmentDetails.push();
            newInvestmentDetail.projectID= project.projectId;
            newInvestmentDetail.investedAmount = msg.value;
            newInvestmentDetail.investorAddress = msg.sender;
        
    }

/////////////////////////////////////////////////////////////////////////////////////////////////////////


    // Function to get all investment details where the sender is the investor
    function getAllMyInvestedProjects() public view returns (InvestmentDetail[] memory) {
        uint256 count = 0;
        // Count the number of investments made by the sender
        for (uint256 i = 0; i < investmentDetails.length; i++) {
            if (investmentDetails[i].investorAddress == msg.sender) {
                count++;
            }
        }

        InvestmentDetail[] memory myInvestments = new InvestmentDetail[](count);
        uint256 j = 0;
        // Collect the investment details made by the sender
        for (uint256 i = 0; i < investmentDetails.length; i++) {
            if (investmentDetails[i].investorAddress == msg.sender) {
                myInvestments[j] = investmentDetails[i];
                j++;
            }
        }

        return myInvestments;
    }
}