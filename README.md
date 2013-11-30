# The Verso Ruby Gem

A Ruby wrapper for the Virginia CTE Resource Center's [Web
API](http://api.cteresource.org), providing access to Virginia's Career and
Technical Education curriculum, course, and occupation data.

## Installation

The verso gem has been tested with Ruby 2.0.0, 1.9.3, and 1.8.7.

    gem install verso

*or* for the latest changes:

    git clone git://github.com/jlcapps/verso.git
    cd verso
    rake install

## Quick Start

The wrapper should make a great starting point for getting course,
curriculum, and occupation data out of Verso. The classes available in
lib/verso correspond to the resources described in the [API
documentation](http://api.cteresource.org/docs). The usual points of entry
are the [Cluster List](http://api.cteresource.org/docs/clusters), the
[Course List](http://api.cteresource.org/docs/courses), the [Occupation
List](http://api.cteresource.org/docs/occupations), and the [Credential
List](http://api.cteresource.org/docs/credentials).

### Start with Clusters

    require 'verso'
    cluster = Verso::ClusterList.new.last
    cluster.pathways.first.title # => "Facility and Mobile Equipment Maintenance"
    cluster.pathways.first.occupations.first.title # => "Aircraft Mechanic and Service Technician"
    cluster.pathways.first.occupations.first.related_courses.first.title # => "Automotive Technology I"

### Start with Courses

    require 'verso'
    course = Verso::CourseList.new(:code => "6321").first
    course.title # => "Accounting, Advanced"
    da = course.duty_areas[5]
    da.title # => "Using Technology to Implement Accounting Procedures"
    da.tasks.last.statement # => "Apply emerging technology trends used in the accounting profession."

### Start with Occupations

Search for Occupations, get back lists of "occupation data," i.e., a list of lists of Occupations, grouped by Cluster and Pathway. To wit:

    require 'verso'
    ods = Verso::OccupationList.new(:text => "golf")
    ods.count # => 3
    ods.first.cluster.title # => "Agriculture, Food and Natural Resources"
    ods.first.pathway.title # => "Environmental Service Systems"
    ods.first.occupations.count # => 3
    occupation = ods.first.occupations.first
    occupation.title => "Turf Farmer"
    course = occupation.related_courses.last.title # => "Turf Grass Applications, Advanced"

### Start with Credentials

    require 'verso'
    creds = Verso::CredentialList.new(:text => "programming")
    creds.first.title # => "Computer Programming (NOCTI)"
    creds.first.related_courses.last # => "Programming, Advanced"

## New! verso-mt command line tool

verso-mt is a command line tool for generating the simpler sorts of CSV reports
from the CTE Resource Center Web API data. If you need to work on *collections*
of related resources -- all the occupations related to a course, say, or all
the courses related to a course, or all the credentials related to a course --
then verso-mt won't help. You'll need to write a script. But if you only need a
report from attributes on courses, credentials, or occupations, verso-mt
totally makes this easy. It will even let you reach into related objects -- an
occupation's pathway, say, or a credential's source.

You can see a help message by typing `verso-mt -h`. Three sorts of resources
can be fetched: course, credential, and occupation. Course is the default. Use
the -q option to specify query parameters. The parameters permissible are
discussed in the API documentation for CourseList, CredentialList, and
OccupationList. Separate the parameter from its value with a colon (:) and
separate multiple parameters with a plus (+), e.g. text:foo+edition:2013.
Filters, specified with the -f option are formed the same way, but are used by
verso-mt to filter out results after they're fetched from the server, based on
a fuzzy match against the specified attribute. Specify the columns you wish to
see in your CSV report with the -c option and a comma-separated list of
attributes. You can use dot notation to reach into a related object. E.g., `-c
title,source.title` could be used to get the title and source title for a list
of credentials.

Here are some examples:

### Similar to examples/copyright_year.rb

In this example, we do not specify the resource. It defaults to course.

    verso-mt -c title,code,frontmatter.copyright_year,related_resources

### similar to examples/course_notes.rb

    verso-mt -c code,title,notes

### similar to examples/cpo.rb

Here we use the '-q' query parameter. You can send it any parameter mentioned
in the API documentation for the corresponding resource. Here we are sending a
wildcard (i.e., everything) in the text parameter for occupations.

    verso-mt -r occupation -q text:* -c title,pathway.title,pathway.cluster.title

### similar to examples/credential_cost.rb

    verso-mt -r credential -c title,cost

### similar to examples/credential_sources.rb

Note in this example, we are reaching into the source, a related object, using
dot notation.

    verso-mt -r credential -c title,source.title,contractor_name

### equivalent to examples/hours.rb

Note in this example, we are using '-f' the filtering option. We ask it to
filter out only courses that have 140 hours.

    verso-mt -f hours:140 -c title,code,hours

### equivalent to examples/hs_and_ms.rb

Note we are specifying two filters here.

    verso-mt -f is_hs?:true+is_ms?:true

### equivalent to examples/hs_v_ms.rb

    verso-mt -c title,code,is_ms?,is_hs?

### equivalent to examples/passing_score.rb

    verso-mt -r credential -c title,source.title,passing_score

### all the courses related to 'energy' in 2013 edition with 'technology' in title

    verso-mt -r course -q text:energy+edition:2013 -f title:technology -c title,code,edition

### search credentials for 'web' and return all where source title matches nocti

    verso-mt -r credential -q text:web -f source.title:nocti -c title,source.title

## Additional Documentation

* [http://api.cteresource.org/docs](http://api.cteresource.org/docs)
* [http://rubydoc.info/gems/verso/](http://rubydoc.info/gems/verso/)

In general, the objects returned from the wrapper should respond to calls to
the attributes described in the API documentation. Open an issue on GitHub or
send an email to lcapps@cteresource.org if you have questions or concerns.
