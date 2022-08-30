version 1.0

task getDate {
    command {
        date
        cal
    }
    runtime {
        docker: "cr-cn-beijing.volces.com/bio-island/samtools:v1.0"
    }
    output {
        String curDate = read_string(stdout())
    }
}

task countWord {
    input {
        String date
        File inputFile 
    }
    command {
        wc ${inputFile}
        echo ${date}
    }
    output {
        String outStr = stdout()
    }
}

workflow runDocker {
    input {
        File inputFile
    }
    call getDate {}
    call countWord {
        input:
          date = getDate.curDate,
          inputFile = inputFile 
    }
    output {
        String getDateOut = getDate.curDate
        String getCountOut = read_string(stdout())
    }
}