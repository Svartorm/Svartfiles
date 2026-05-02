#!/bin/bash

# Function to display help
display_help() {
    echo "Usage: $0 [options] [parameter]"
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message"
    echo
    echo "Parameter:"
    echo '  Provide an animal type from : ["fox", "yeen", "dog", "manul", "snek", "poss", "leo", "serval", "bleat", "shiba", "racc", "dook", "ott", "snep", "woof", "chi", "capy", "bear", "bun", "caracal", "puma", "mane", "marten", "tig", "wah", "skunk", "jaguar", "yote"]'
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    display_help
    exit 0
fi

# Set the API endpoint
if [ -n "$1" ]; then
    url="https://api.tinyfox.dev/img?animal=$1"
else
    url="https://tinyfox.dev/img?animal=animal"
fi

# Download the image
image_file="/tmp/api_image.png"
curl -s -o "$image_file" "$url"

# Check if viu is installed
if ! command -v viu &> /dev/null; then
    echo "viu is not installed. Please install viu to display images."
    exit 1
fi

# Display the image using viu
viu "$image_file"
