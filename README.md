# README
Demonstrates a way to produce release notes for a repo. 

## Prequisites
You'll need to have gomplates installed 

```sh
brew install gomplate
```

## TODO: 
* The first commit is not included  
* Add a githook for validating the commit format. 
* Pull the versions from tags?
* Limit generation to particular branch.
* How do I get the gitconfig to automatically install? 
* Add a pullrequest template https://help.github.com/en/github/building-a-strong-community/creating-a-pull-request-template-for-your-repository


## Initiate the repo
Copy the .gitmessage and install into the local reop.  This can be done globally.  But then it affects all repos. 

```sh
git config commit.template .gitmessage  
```

When you look at your config you should now see it.  
```sh
git config --list 
git config --local --list    
```

You can also verify in VSCode by opening the repo directory and looking at the Source Control template commit.  

## Committing 
You can create an exmaple commit by filling in the template. 

It contains fields for Subject, Problem, Solution, Notes.  You should also include the ticket in the subject as this is the line used to build the notes. 

```
Subject (50 chars) (#include ticket) 

Problem (Reason for Commit)
Solution (List of Changes)
Notes (Special Instructions, Testing Steps, etc)
```

## Build release notes 
Running the ./generate_release.sh will list out the current commits. 

```sh
# generate RELEASE_MOTES.md
./generate_release.sh release

# generate DEPLOYMENTS.md
./generate_release.sh deployment
```

Versions are listed as ranges.  These are then reverse sorted and added to the [RELEASE_NOTES.md](./RELEASE_NOTES.md)  
```
git log  --pretty=format:"'%h', '%an', '%s'" 162856a..ea5f6b1 > ./output/1.0.txt
git log  --pretty=format:"'%h', '%an', '%s'" ea5f6b1..0ea7306 > ./output/1.1.txt
git log  --pretty=format:"'%h', '%an', '%s'" 0ea7306..acf1304 > ./output/1.2.txt
git log  --pretty=format:"'%h', '%an', '%s'" acf1304..58ee502 > ./output/1.3.txt
git log  --pretty=format:"'%h', '%an', '%s'" 58ee502..5144e24 > ./output/2.0.txt
git log  --pretty=format:"'%h', '%an', '%s'" 5144e24..7130ef6 > ./output/2.1.txt
```

## Amending commits
Amending commits where you have forgot to add the ticket.
```
git commit --amend
```

## Debugging Templates Hint
Clean the ./output directory and comment out all but one of the git log outputs.
This makes the script run faster and allows quick testing of template modifications

