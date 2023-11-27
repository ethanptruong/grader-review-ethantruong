CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


if [ ! -f student-submission/ListExamples.java ]; then
    echo "Error: ListExamples.java not found in the submission."
    exit 1
fi


cp TestListExamples.java student-submission/
cp -r lib student-submission/


cd student-submission


javac -cp $CPATH ListExamples.java TestListExamples.java
if [ $? -ne 0 ]; then
    echo "Error: Compilation failed."
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test_results.txt
if [ $? -ne 0 ]; then
    echo "Error: Tests failed to run."
    exit 1
fi


echo "tests passed."
