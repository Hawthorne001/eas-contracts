// SPDX-License-Identifier: MIT

pragma solidity 0.7.6;
pragma abicoder v2;

import "./IAOVerifier.sol";

/**
 * @title A struct representing a record for a submitted AO (Attestation Object).
 */
struct AORecord {
    // A unique identifier of the AO.
    bytes32 uuid;
    // Optional schema verifier.
    IAOVerifier verifier;
    // Auto-incrementing index for reference, assigned by the registry itself.
    uint256 index;
    // Custom specification of the AO (e.g., an ABI).
    bytes schema;
}

/**
 * @title The global AO registry interface.
 */
interface IAORegistry {
    /**
     * @dev Triggered when a new AO has been registered
     * @param uuid The AO UUID.
     * @param index The AO index.
     * @param schema The AO schema.
     * @param verifier An optional AO schema verifier.
     * @param attester The address of the account used to register the AO.
     */
    event Registered(bytes32 indexed uuid, uint256 indexed index, bytes schema, IAOVerifier verifier, address attester);

    /**
     * @dev Submits and reserve a new AO
     * @param schema The AO data schema.
     * @param verifier An optional AO schema verifier.
     * @return The UUID of the new AO.
     */
    function register(bytes calldata schema, IAOVerifier verifier) external returns (bytes32);

    /**
     * @dev Returns an existing AO by UUID
     * @param uuid The UUID of the AO to retrieve.
     * @return The AO data members.
     */
    function getAO(bytes32 uuid) external view returns (AORecord memory);

    /**
     * @dev Returns the global counter for the total number of attestations
     * @return The global counter for the total number of attestations.
     */
    function getAOCount() external view returns (uint256);
}
