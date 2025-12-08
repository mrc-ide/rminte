# rminte: R Interface to Python's MINTe Package

An R interface to the Python 'minte' package, providing neural
network-based malaria scenario predictions for evaluating intervention
strategies including ITNs (Insecticide-Treated Nets), IRS (Indoor
Residual Spraying), and LSM (Larval Source Management).

## Main Functions

- [`run_minter_scenarios`](https://mrc-ide.github.io/rminte/reference/run_minter_scenarios.md):
  Main entry point for running scenarios

- [`run_mintweb_controller`](https://mrc-ide.github.io/rminte/reference/run_mintweb_controller.md):
  Simplified web interface controller

- [`run_malaria_emulator`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md):
  Direct emulator interface

- `create_scenario_plots`: Create visualizations

## Utility Functions

- [`calculate_overall_dn0`](https://mrc-ide.github.io/rminte/reference/calculate_overall_dn0.md):
  Calculate net effectiveness

- [`available_net_types`](https://mrc-ide.github.io/rminte/reference/available_net_types.md):
  Get supported net types

- [`preload_all_models`](https://mrc-ide.github.io/rminte/reference/preload_all_models.md):
  Pre-load models into cache

- [`clear_cache`](https://mrc-ide.github.io/rminte/reference/clear_cache.md):
  Clear model cache

## Setup

- [`minte_available`](https://mrc-ide.github.io/rminte/reference/minte_available.md):
  Check if minte is available

- [`install_minte`](https://mrc-ide.github.io/rminte/reference/install_minte.md):
  Install minte Python package

## See also

Useful links:

- <https://github.com/mrc-ide/rminte>

- <https://mrc-ide.github.io/rminte/>

- Report bugs at <https://github.com/mrc-ide/rminte/issues>

## Author

**Maintainer**: OJ Watson <o.watson15@imperial.ac.uk>
([ORCID](https://orcid.org/0000-0003-2374-0741))
