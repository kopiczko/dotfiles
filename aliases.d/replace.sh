replace() {
    local a=$1; shift
    local b=$1; shift
    local dir=$1; shift
    # escape backshashes
    local a="${a//\//\\/}"
    local b="${b//\//\\/}"
    for file in $(find $dir -type d \( -path ./.git -o -path ./vendor \)  -prune -o -print | grep '.*\.go'); do
        sed -i -e "s/${a}/${b}/g" $file
    done
}
