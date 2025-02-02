// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ILayerZeroEndpoint.sol";

/// @title LayerZero bridge storage
/// @author zk.link
/// @dev Do not initialize any variables of this contract
/// Do not break the alignment of contract storage
contract LayerZeroStorage {

    // evm address is 20 bytes
    uint8 constant internal EVM_ADDRESS_LENGTH = 20;

    enum APP {ZKL, ZKLINK}

    /// @notice ZkLink network governor
    address public networkGovernor;
    /// @notice LayerZero endpoint that used to send and receive message
    ILayerZeroEndpoint public endpoint;
    /// @notice bridge contract address on other chains
    mapping(uint16 => bytes) public destinations;
    /// @notice user applications
    mapping(APP => address) public apps;
    /// @notice failed message of lz non-blocking model
    /// @dev the struct of failedMessages is (srcChainId => srcAddress => nonce => payloadHash)
    /// srcChainId is the id of message source chain
    /// srcAddress is the trust remote address on the source chain who send message
    /// nonce is inbound message nonce
    /// payLoadHash is the keccak256 of message payload
    mapping(uint16 => mapping(bytes => mapping(uint64 => bytes32))) public failedMessages;

    event UpdateDestination(uint16 indexed lzChainId, bytes destination);
    event UpdateAPP(APP indexed app, address contractAddress);
    event MessageFailed(uint16 indexed srcChainId, bytes srcAddress, uint64 nonce, bytes payload);
    event SendZKL(uint16 indexed dstChainId, uint64 nonce, address sender, bytes receiver, uint amount);
    event ReceiveZKL(uint16 indexed srcChainId, uint64 nonce, address receiver, uint amount);
    event SendSynchronizationProgress(uint16 indexed dstChainId, uint64 nonce, bytes32 syncHash, uint progress);
    event ReceiveSynchronizationProgress(uint16 indexed srcChainId, uint64 nonce, bytes32 syncHash, uint progress);
}
