# Assuming you have a Vehicle model with ActiveStorage set up for brand_logo

# Create a new Vehicle object and attach the image directly
vehicle = Vehicle.create!(
    brand: "Porsche",
    model: "GT3 RS",
    price_per_day: 1000,
    brand_logo: {
        io: File.open("/Users/parshwapatil/Rails/VehicleRentalApp-P2/app/assets/images/porsche.png"),
        filename: "porsche.png"
    }
)
