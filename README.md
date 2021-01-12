# Beacon iOS SDK

[![release]](https://img.shields.io/github/v/tag/airgap-it/beacon-ios-sdk?include_prereleases)

> Connect Wallets with dApps on Tezos

[Beacon](https://walletbeacon.io) is an implementation of the wallet interaction standard [tzip-10](https://gitlab.com/tzip/tzip/blob/master/proposals/tzip-10/tzip-10.md) which describes the connection of a dApp with a wallet.

## About

The `Beacon iOS SDK` provides iOS developers with tools useful for setting up communication between native wallets supporting Tezos and dApps that implement [`beacon-sdk`](https://github.com/airgap-it/beacon-sdk).

<!-- TODO: once published ## Installation -->

<!-- TODO: ## Documentation -->

<!-- TODO: ## Project Overview -->

## Examples

The snippets below show how to quickly setup listening for incoming Beacon messages.

For more examples please see our `demo` app (WIP).

### Create a Beacon client and listen for incoming messages

```swift
import BeaconSDK

class BeaconController {
    private var client: Beacon.Client?
    
    ...
    
    func startBeacon() {
        Beacon.Client.create(with: Beacon.Client.Configuration(name: "My App")) { result in
            switch result {
            case let .success(client):
                self.client = client
                self.listenForBeaconMessages()
            case let .failure(error):
                /* handle error */
            }
        }
    }
    
    func listenForBeaconMessages() {
        client?.connect { result in
            switch result {
            case .success(_):
                self.client?.listen { request in 
                    /* process messages */ 
                }
            case let .failure(error):
                /* handle error */
            }
        }
    }
}
```

<!-- TODO: ## Development -->

---
## Related Projects

[Beacon SDK](https://github.com/airgap-it/beacon-sdk) - an SDK for web developers (dApp & wallet)

[Beacon Android SDK](https://github.com/airgap-it/beacon-android-sdk) - an SDK for Android developers (wallet)
