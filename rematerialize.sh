#!/bin/sh

$(nix-build projects.nix --no-out-link -A '"8.8.3"'.stack-nix.passthru.updateMaterialized)
$(nix-build projects.nix --no-out-link -A '"8.8.4"'.stack-nix.passthru.updateMaterialized)
$(nix-build projects.nix --no-out-link -A '"8.10.1"'.stack-nix.passthru.updateMaterialized)
$(nix-build projects.nix --no-out-link -A '"8.10.2"'.stack-nix.passthru.updateMaterialized)
