BASE_DIR=$(which 1pctl|xargs grep '^BASE_DIR='| cut -d'=' -f2)
echo "$(date): 1panel install directory: $BASE_DIR"

if [ -z "$BASE_DIR" ]; then
    echo "Error: 1panel install directory not found."
    exit 1
fi

echo "$(date): cloning repository..."

repo_directory=$BASE_DIR"/1panel/resource/apps/local/1panel-appstore"

git clone --depth=1 https://github.com/zbronya/1panel-appstore $repo_directory

apps_directory=$repo_directory"/apps"

local_directory=$BASE_DIR"/1panel/resource/apps/local"

echo "$(date): checking for updated apps..."
for app_directory in $apps_directory/*; do
    app_name=$(basename "$app_directory")

    if [ -d "$local_directory/$app_name" ]; then
        rm -rf "$local_directory/$app_name"
        cp -r "$app_directory" "$local_directory/"
        echo "$(date): copied and replaced directory $app_directory to $local_directory/"
    else
        cp -r "$app_directory" "$local_directory/"
        echo "$(date): copied directory $app_directory to $local_directory/"
    fi
done

echo "$(date): clean installed directory"
rm -rf $repo_directory
echo "$(date): finish clean installed directory"

echo "$(date): done!"