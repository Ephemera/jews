set -e
if [ "$TRAVIS_BRANCH" = "master" ] && [ "$TRAVIS_PULL_REQUEST" = false ] && [ "$GITHUB_TOKEN" != "" ]; then
    echo "machine github.com login reactjs-bot password $GITHUB_TOKEN" >~/.netrc
    git config --global user.name "Travis CI"
    git config --global user.email "travis@reactjs.org"

    npm run production

    git status

    if ! git diff-index --quiet HEAD --; then
        git add dist/jews.user.js
        git commit -m "release new version"
        git push origin release
fi
