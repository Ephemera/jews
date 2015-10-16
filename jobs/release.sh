set -e
if [ "$TRAVIS_BRANCH" = "master" ] && [ "$TRAVIS_PULL_REQUEST" = false ] && [ "$GITHUB_TOKEN" != "" ]; then
    echo "machine github.com login reactjs-bot password $GITHUB_TOKEN" >~/.netrc
    git config --global user.name "jews-bot"
    git config --global user.email "jews@chan.moe"

    npm run production

    RELEASE_DIR="$TRAVIS_BUILD_DIR"/../jews-release
    echo "git clone release"
    git clone https://github.com/disjukr/jews.git $RELEASE_DIR
    echo "pushd to RELEASE_DIR"
    pushd $RELEASE_DIR
    echo "git checkout release"
    git checkout release
    echo "git merge master"
    git merge master
    echo "mkdir dist"
    mkdir dist
    echo "cp jews.user.js"
    cp $TRAVIS_BUILD_DIR/dist/jews.user.js dist/jews.user.js
    echo "git add dist/jews.user.js"
    git add dist/jews.user.js
    echo "git stage"
    git stage
    echo "git commit"
    git commit -m "release new version"
    echo "git push origin release"
    git push origin release
    echo "popd"
    popd
fi
