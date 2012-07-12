# The Verso Ruby Gem

A Ruby wrapper for the Virginia CTE Resource Center's [Web
API](http://api.cteresource.org), providing access to Virginia's Career and
Technical Education curriculum, course, and occupation data.

## Installation

    git clone git://github.com/jlcapps/verso.git
    cd verso
    rake install

## Caveat

This gem has been *extracted* from a larger project, the Web application that
presents [Verso](http://www.cteresource.org/verso/), the [Administrative
Planning Guide](http://www.cteresource.org/apg/), and the [Career Planning
Guide](http://www.cteresource.org/cpg/) on the Virginia CTE Resource Center Web
site. For this reason the object interfaces are sometimes inconsistent (for
instance collection objects do not always respond to all the expected
methods -- `#to_a` is your friend), the specs are incomplete, and the
documentation is nil.

All that said, the wrapper is reasonably complete, and should make a great
starting pointing for getting course, curriculum, and occupation data out of
Verso. The classes available in lib/verso correspond to the resources described
in the [API documentation](http://api.cteresource.org/docs). The usual points
of entry are the [Cluster List](http://api.cteresource.org/docs/clusters), the
[Course List](http://api.cteresource.org/docs/courses), the [Occupation
List](http://api.cteresource.org/docs/occupations), and the [Credential
List](http://api.cteresource.org/docs/credentials).

## Quick Start

### Start with Clusters

    require 'verso'
    cluster = Verso::ClusterList.new.last
    cluster.pathways.first.title # => "Facility and Mobile Equipment Maintenance"
    cluster.pathways.first.occupations.first.title # => "Aircraft Mechanic and Service Technician"
    cluster.pathways.first.occupations.first.related_courses.first.title # => "Automotive Technology I"

### Start with Courses

    require 'verso'
    course = Verso::CourseList.new(:code => "6321").first
    course.title # => "Accouting, Advanced"
    da = course.duty_areas.to_a[5] # I warned you about the incomplete interface . . . .
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

In general, the objects returned from the wrapper should respond to calls to
the attributes described in the API documentation. Open an issue on GitHub or
send an email to lcapps@cteresource.org if you have questions or concerns.
