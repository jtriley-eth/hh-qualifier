// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

abstract contract Initializeable {
    error Initialized();
    error Initializing();

    bool private _initialized;
    bool private _initializing;

    modifier initializer() {
        if (_initialized) revert Initialized();
        if (_initializing) revert Initializing();
        _initializing = true;
        _;
        _initializing = false;
        _initialized = true;
    }
}
