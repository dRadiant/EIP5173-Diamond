// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

library nFRStorage {
    bytes32 internal constant STORAGE_SLOT = keccak256("nFR.contract.storage");

    struct FRInfo {
        uint8 numGenerations; //  Number of generations corresponding to that Token ID
        uint256 percentOfProfit; // Percent of profit allocated for FR, scaled by 1e18
        uint256 successiveRatio; // The common ratio of successive in the geometric sequence, used for distribution calculation
        uint256 lastSoldPrice; // Last sale price in ETH mantissa
        uint256 ownerAmount; // Amount of owners the Token ID has seen
        bool isValid; // Updated by contract and signifies if an FR Info for a given Token ID is valid
    }

    struct ListInfo {
        uint256 salePrice; // ETH mantissa of the listed selling price
        address lister; // Owner/Lister of the Token
        bool isListed; // Boolean indicating whether the Token is listed or not
    }

    struct Layout {
        FRInfo _defaultFRInfo;
        
        mapping(uint256 => FRInfo) _tokenFRInfo;

        mapping(uint256 => address[]) _addressesInFR; // In the future, we should add _addressInFR to the FRInfo struct as per the EIP, instead of seperating it, but right now it would break the current untrading contract deployments

        mapping(address => uint256) _allottedFR;

        mapping(uint256 => ListInfo) _tokenListInfo;
    }

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}
