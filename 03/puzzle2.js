#!/usr/bin/env node
const fs = require('fs');
const returnMoreFrequent = function(summary) {
    return summary.numberOfOnes >= summary.numberOfZeros ? '1' : '0';
}
const returnLessFrequent = function(summary) {
    return summary.numberOfOnes >= summary.numberOfZeros ? '0' : '1';
}

try {
    const data = fs.readFileSync('input.txt', 'utf8')
    report = data.split('\n');
    console.log("Report data: ", report);    
    let initialPosition = 0;
    console.log("Calculating Oxygen Rating...");
    let oxygenGeneratorRating = filterReportValues(report, initialPosition, returnMoreFrequent);

     separator();
    
     console.log("Calculating CO2 Rating...");
     let CO2Rating = filterReportValues(report, initialPosition, returnLessFrequent);
     
     separator();
    
     console.log("Oxygen Generator Rating (binary): ", oxygenGeneratorRating);
     console.log("CO2 Rating (binary): ", CO2Rating);
    
     let oxygenRatingDecimal = parseInt(oxygenGeneratorRating, 2);
     let co2RatingDecimal = parseInt(CO2Rating, 2);
     console.log("Oxygen Generator Rating (decimal): ", oxygenRatingDecimal);
     console.log("CO2 Rating (decimal): ", co2RatingDecimal);

     separator();

     console.log("Oxygen Rating*CO2 Rating: ", (oxygenRatingDecimal*co2RatingDecimal));
} catch (err) {
    console.error(err)
}

function separator() {
    console.log("\n*****************************\n");    
}

// Let's make ourselves miserable with recursion
function filterReportValues(valuesToFilter, pos, criteriaFunction) {
    if (valuesToFilter.length > 1) {
        let { criteria, position } = getBitCriteria(valuesToFilter, pos, criteriaFunction);        
        console.log("Values to be filtered: ", valuesToFilter);
        console.log("Criteria: ", criteria);
        console.log("Position: ", position);
        filteredValues = valuesToFilter.filter((value) => {
            return value.split('')[position] == criteria;
        });
        console.log(`Bit criteria: ${criteria}, Filtered values for position ${pos}`, filteredValues);        
        console.log("==============================");        
        let newPosition = pos + 1;
        return filterReportValues(filteredValues, newPosition, criteriaFunction);
    } else if (valuesToFilter.length == 1) {        
        return valuesToFilter[0];
    }
}

// Trying to be clever with the sum and quotient BS was too complicated to debug
// Just be totally explicit about what is happening here
function getBitCriteria(inputArray, position, compareFunc) {
    let digitsByPosition = [];

    // For each value in the report data, split the string into an array of 1s and 0s
    inputArray.map((value) => {
        return value.split('')
    })
    // For each array of 1s and 0s, put each 1 or 0 in the appropriate bucket as
    // determined by its index in the array
    // inputArray[0], [1, 0, 1, 1, 0]
    // digitsByPosition = [
    //  ['1'], <-- index 0
    //  ['0'], <-- index 1
    //  ['1'], <-- index 2
    //  ['1'], <-- index 3
    //  ['0'], <-- index 4                        
    // ]
    // inputArray[1] = [1, 1, 0, 0, 1]
    // digitsByPosition = [
    //  ['1', '1'], <-- index 0
    //  ['0', '1'], <-- index 1
    //  ['1', '0'], <-- index 2
    //  ['1', '0'], <-- index 3
    //  ['0', '1'], <-- index 4                        
    // ]

    .forEach(valueArray => {
        valueArray.forEach((digit, index) => {
            if (!digitsByPosition[index]) {
                digitsByPosition[index] = [];
            }
            digitsByPosition[index].push(digit);
        });
    })

    // Doesn't get more explicit than literally naming the keys numberOfZeros and numberOfOnes
    // eg, digitsByPosition = [
    //  ['1', '1', '0', '1', '0'],
    //  ['0', '1', '1', '0', '1'],
    //  ['1', '0', '0', '1', '1'],
    //  ['1', '0', '0', '0', '1'],
    //  ['0', '1', '1', '1', '1'],
    // ] and then becomes:
    // digitsByPosition = [
    //  { numberOfZeros: 2, numberOfOnes: 3, criteria: 1, position: 0 } <-- criteria is the digit with the HIGHER frequency
    //  { numberOfZeros: 2, numberOfOnes: 3, criteria: 1, position: 1 }
    //  { numberOfZeros: 2, numberOfOnes: 3, criteria: 1, position: 2 }
    //  { numberOfZeros: 3, numberOfOnes: 2, criteria: 0, position: 3 }
    //  { numberOfZeros: 1, numberOfOnes: 4, criteria: 1, position: 4 }
    // ]

    let counts = digitsByPosition.map((wordsArray, index) => {
        let numberOfZeros = wordsArray.filter(el => {
            return el == '0';
        }).length
        let numberOfOnes = wordsArray.filter(el => {
            return el == '1';
        }).length        
        return {
                numberOfZeros,
                numberOfOnes,
                criteria: compareFunc({numberOfOnes, numberOfZeros, position: index}),
                position: index
            };
    });

    // After we did all that brute force work, looks like we really only want one of them as indicated by the position argument, wompwomp!
    // Return the element of counts that has the same value of position as the position argument
    let summary = counts.filter(countSummary => {
        return countSummary.position == position;
    });

    // It should be a list of length 1, so just get rid of the array-ness of it
    return summary[0];
}