replace() {
    local a=$1; shift
    local b=$1; shift
    local dir=$1; shift
    # escape backshashes
    local a="${a//\//\\/}"
    local b="${b//\//\\/}"
    for file in $(find $dir \( -path ./.git -o -path ./vendor \)  -prune -o -type f -print); do
        sed -i -e "s/${a}/${b}/g" $file
    done
}
