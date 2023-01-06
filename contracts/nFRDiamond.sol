// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@solidstate/contracts/proxy/diamond/SolidStateDiamond.sol";
import {IERC165} from "@solidstate/contracts/introspection/IERC165.sol";
import {ERC165Storage} from "@solidstate/contracts/introspection/ERC165Storage.sol";
import {ERC721MetadataStorage} from "@solidstate/contracts/token/ERC721/metadata/ERC721MetadataStorage.sol";
import {IERC721} from "@solidstate/contracts/token/ERC721/IERC721.sol";

import "./nFR/InFR.sol";

contract nFRDiamond is SolidStateDiamond {
    using ERC165Storage for ERC165Storage.Layout;

    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI
    ) {
        ERC721MetadataStorage.Layout storage l = ERC721MetadataStorage.layout();
        l.name = name;
        l.symbol = symbol;
        l.baseURI = baseURI;

        ERC165Storage.layout().setSupportedInterface(
            type(IERC165).interfaceId,
            true
        );
        ERC165Storage.layout().setSupportedInterface(
            type(IERC721).interfaceId,
            true
        );
        ERC165Storage.layout().setSupportedInterface(
            type(InFR).interfaceId,
            true
        );
    }
}
