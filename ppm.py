#! /usr/bin/env python3

import json

records = []
# load the ppm.tdat
with open("ppm.tdat", "r") as file:
    for line in file:
        line = line.strip()
        if line.startswith("line[1] = "):
            fields = line.split(" ")[2:]
            #print (f"Fields: {fields}")
        elif line.startswith("PPM "):
            line = line[4:]
            record = {}
            values = line.split("|")
            for i, field in enumerate(fields):
                if len(values[i]) > 0:
                    record[field] = values[i]
            records.append(record)
            #print (f"Record: {record}")

print (f"Read: {len(records)} records")

with open("ppm.json", "w") as file:
    json.dump(records, file)
