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

The wrapper should make a great starting pointing for getting course,
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

## Additional Documentation

* [http://api.cteresource.org/docs](http://api.cteresource.org/docs)
* [http://rubydoc.info/gems/verso/](http://rubydoc.info/gems/verso/)

In general, the objects returned from the wrapper should respond to calls to
the attributes described in the API documentation. Open an issue on GitHub or
send an email to lcapps@cteresource.org if you have questions or concerns.
