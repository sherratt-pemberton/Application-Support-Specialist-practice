This is a simple database that represents a medical center to practice resolving issue I might face as an Application Support Specialist. Along with the database there is a set of 40 tickets. 1-20 contain a veriety of issues to resolve which are constraint violations and resolved by safely clearing the violation, while leaving the database auditable. 21-40 contain higher level investagation, more along the lines of reporting.

the seed and incident seed data are in seperate files and should both be run.

In MySQL workbench Run:
medical db schema.sql
medical db  data.sql (seed data)
medical db  defects.sql (incident seed data)
