CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission #clones repository
echo 'Finished cloning'


if ! [[ -f "./student-submission/ListExamples.java" ]]
    then #check if right file
        echo 'this is the wrong file'
        exit 1
fi
files='find ./student-submission/*.java ./TestListExamples.java'
for file in $files #copies to new dir
do
    if [[ -f $file ]]
    then #check if right file
        cp -r $file './grading-area'
    fi
done
cd grading-area
javac -cp $CPATH *.java
if ! [[ $? -eq 0 ]]
    then
    echo 'the code doesn't compile
        exit 2
fi
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt
grep "There was" "output.txt"
