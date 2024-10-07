module MyModule::CommunityGarden {

    use aptos_framework::signer;
    use std::vector;

    /// Struct representing a garden plot available for rent.
    struct GardenPlot has store, key {
        owner: address,          // Address of the plot owner
        plot_id: vector<u8>,     // Unique identifier for the garden plot
        is_available: bool,      // Whether the plot is available for rent
    }

    /// Function to create and list a garden plot for rent.
    public fun create_garden_plot(owner: &signer, plot_id: vector<u8>) {
        let plot = GardenPlot {
            owner: signer::address_of(owner),
            plot_id,
            is_available: true,
        };
        move_to(owner, plot);
    }

    /// Function to rent a garden plot.
    public fun rent_garden_plot(renter: &signer, plot_owner: address) acquires GardenPlot {
        let plot = borrow_global_mut<GardenPlot>(plot_owner);

        // Ensure the plot is available for rent
        assert!(plot.is_available, 1);

        // Mark the plot as rented (not available)
        plot.is_available = false;

        // The actual rental payment is assumed to be handled off-chain
    }
}
