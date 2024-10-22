# Retirement
This app has been retired and lives for reference in Confluence here: https://confluence.hl7.org/display/EST/Tooling+Catalog 
Forwarding was implemented for previous URL (toolsandservicesinventory.hl7.org)

# HL7 Tooling Catalogue

The HL7 tooling Catalogue was created in response to a need to identify, understand and 
evaluate the various tools used by HL7 in it's processes. Additional tools have also been 
included in the catalogue for historical and general reasons of importance. The tools that
are a) actual tools (some items are more documents than tools), and b) internal and/or 
part of an HL7 core process (balloting, publication, member management) all have an assessment
of the current viability of the tool performed.

## Application Architecture

Detailed architecture is discussed in other documents but stated simply the application is a
web delivered query tool into a database. It is built using Ruby on Rails (4.2.6) 
running against a PostgreSQL (9.5) database. In the current version the data is pre-loaded,
and the background database is static. Initial data collection was done using a set of
Excel spreadsheets that were saved into CSV format files which are in turn processed to 
create a set of database CSV load files. Utilities are provided to completely rebuild the
database from scratch using the database CSV files (which are saved as part of this 
repository).

The application contains database update screens for all of the components. These are 
'turned off' in the current delivered application by means of a server-defined variable. 
If the variable HL7_TOOL_EDITING is set to 'TRUE' in the server run-time environment, the
edit capabilities can be accessed. This is not suitable for a production site and was only
provided to ensure the editing screens were functional. There is currently no user
authentication embedded in the application which would be necessary in a production app.

### Application Environment

The individual working with this code base is expected to be comfortable on a Unix command
line interface or able to convert Unix command line actions into the appropriate DOS
command line actions. The software is built for web-server environments.

With a Rails environment (with Ruby 2.2.2) and PostgreSQL configured, the source can be 
cloned from GitHub. Once the code is on your local drive, pull in any dependencies using 
the standard Bundler command:
```bash
$ git clone https://github.com/astechishin/hl7-tools.git
$ cd hl7-tools
$ bundle update
```
Your environment is now ready

### Data Conversion/Load

The data was collected in three spreadsheets for ease of entry by the development team. These
spreadsheets are then saved in CSV format on MacOS as persons-raw.csv, tools-raw.csv and 
tool-responsibilities-raw.csv (in the db/data-conversion directory). The rest of the process
is accomplished by running 'rake' tasks. At present, due to the limited size of the database,
the entire database is rebuilt for new data items. Once any updates have been made to the
'raw' files and saved the following series of steps will update the load scripts and 
populate a new development database with the data:

```bash
$ rake data:conversion
$ rake db:drop # will delete and destroy any existing hl7-tool databases
$ rake db:create
$ rake db:migrate
$ rake db:migrate RAILS_ENV=test # not needed for only adding data but useful for running tests
$ rake db:csv:load
```

If any of the files in db/load-data actually changed, they should be saved at this point 
with the `git commit/git push` process

### Data Upload to Heroku site

With the updated data loaded into a local PG instance, it can be used to update the 
production database on Heroku. The user must have the Heroku command line tools installed
(https://devcenter.heroku.com/articles/heroku-command-line) and must be a user with 
Admin permissions on the HL7-Tools Heroku application. The following commands make use of 
the Heroku PG CLI and expect that the user is comfortable using a CLI environment. **This 
upload will destroy all of the previous data on the production server and replace it with 
the content of the local database. Only run these commands if you are comfortable with 
these actions.**

The following steps are explained on the Heroku site (https://devcenter.heroku.com/articles/heroku-postgresql#using-the-cli) in more detail. Once the local development
database is set up from the Data Conversion/Load instructions, run the following commands:

```bash
$ heroku pg:reset DATABASE_URL --app hl7-tools
 !    WARNING: Destructive Action
 !    This command will affect the app: hl7-tools
 !    To proceed, type "hl7-tools" or re-run this command with --confirm hl7-tools
> hl7-tools
Resetting DATABASE_URL... done
$ heroku pg:push hl7-tools-dev DATABASE_URL --app hl7-tools
...
...
 pg_restore: setting owner and privileges for INDEX "public.index_tool_dependencies_on_tool_id_and_dependency_id"
 pg_restore: setting owner and privileges for INDEX "public.index_tool_people_on_tool_id_and_person_org_id"
 pg_restore: setting owner and privileges for INDEX "public.tool_txt_idx"
 pg_restore: setting owner and privileges for INDEX "public.unique_schema_migrations"
 pg_restore: setting owner and privileges for FK CONSTRAINT "public.code_values_parent_id_fkey"
 WARNING: errors ignored on restore: 1
```

The data is now available on the Heroku HL7 Tooling Catalogue application

### Other Heroku Configurations

The application is a very simple, standard Heroku installation. If you are creating a new 
Heroku application, ensure that SECRET_KEY_BASE is defined in the Heroku environment (review
secret_key_base in the Rails documentation and the config command on the Heroku developer site).
Heroku deploys are performed using the standard `git push` mechanism.
