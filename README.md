# README

Members of the [MQTT TC](https://www.oasis-open.org/committees/mqtt/) create and manage technical content in this [TC GitHub repository](https://github.com/oasis-tcs/mqtt/) as part of the TC's chartered work (the program of work and deliverables described in its [charter](https://www.oasis-open.org/committees/mqtt/charter.php).

OASIS TC GitHub repositories, as described in [GitHub Repositories for OASIS TC Members' Chartered Work](https://www.oasis-open.org/resources/tcadmin/github-repositories-for-oasis-tc-members-chartered-work), are governed by the OASIS [TC Process](https://www.oasis-open.org/policies-guidelines/tc-process), [IPR Policy](https://www.oasis-open.org/policies-guidelines/ipr), and other policies. While they make use of public GitHub repositories, these repositories are distinct from [OASIS Open Repositories](https://www.oasis-open.org/resources/open-repositories), which are used for development of open source [licensed](https://www.oasis-open.org/resources/open-repositories/licenses) content.

## Description

All contributions will be accepted for consideration without any prejudice or restrictions and evaluated based on technical merit in so far as they conform to this charter and its schedule.

The scope of the TC's work is limited to technical refinements of features organized into the following categories:

- Enhancements for Scalability and Large-Scale Systems including the ability to communicate functional levels, define optional functions, and control resource usage.
- Improved Error Reporting allowing error indications to be returned by both MQTT client and MQTT server with the definition of additional return values.
- Formalize commonly observed patterns including, but not limited to capability discovery, request-response, correlation.
- Extensibility Mechanisms enabling the addition of data fields on packets, including application-extensible data whose interpretation is not specified by MQTT.
- Performance Improvements to address constraints and bottlenecks discovered in previous versions.
- Additional support for Resource Constrained MQTT clients. There is growing demand for messaging solutions optimized for extremely constrained devices, often operating within data networks that have very low bandwidth and/or reliability. In some cases, the runtime environment is unable to support a TCP/IP layer. MQTT for Sensor Networks (MQTT-SN) is well suited to this problem space and is conceptually similar to MQTT. The TC will develop MQTT-SN as an OASIS standard work track product in order to extend the reach of MQTT in IoT solutions that include these constrained environments.

It is often expensive or impractical to immediately upgrade mobile and other field equipment in response to protocol updates. There needs to be a careful balance between feature enhancements and potential disruption to existing implementations.

The newer version of the standard will build on the previous version so that it is straightforward for existing implementations to support multiple versions.

This TC may also produce the following non-normative Committee Notes for the MQTT specification:

- A requirements and recommendations document for enhancements or issues deemed within in scope but which could not be included in the next version of the specification. These will be collected for consideration in a future version of the standardized specification.
- Primers or white papers describing usage examples, scenarios and/or best practices.
- Test scenario descriptions.

## Out of Scope

Any proposal that does not contribute to one or more of the categories listed in the Scope of Work section is deemed out of scope. Furthermore, any proposal that cannot be completed within the deliverable milestone is deemed out of scope. The following items are specifically out of scope:

- The TC will not specify mappings of MQTT functions described in the specifications, to any programming language or particular messaging middleware.
- The TC will not produce reference implementations of the protocol.
- Except for the values and fields directly related to the MQTT protocol, the TC will not prescribe the payload format of messages that are published according to the specifications.
- The TC will not identify MQTT topics nor prescribe any mechanism or convention for classification of MQTT topics or topic spaces.
- Transport level security is assumed and no mandatory security features will be added.
- Contributions to this TC which are out of scope for this charter may be accumulated and taken into consideration for potential development in a future charter.
  
## Contributions

As stated in this repository's [CONTRIBUTING](https://github.com/oasis-tcs/mqtt/blob/master/CONTRIBUTING.md) file, contributors to this repository must be Members of the OASIS MQTT TC for any substantive contributions or change requests.  Anyone wishing to contribute to this GitHub project and [participate](https://www.oasis-open.org/join/participation-instructions) in the TC's technical activity is invited to join as an OASIS TC Member. Public feedback is also accepted, subject to the terms of the [OASIS Feedback License](https://www.oasis-open.org/policies-guidelines/ipr#appendixa). 

## Licensing

Please see the [LICENSE](https://github.com/oasis-tcs/mqtt/blob/master/LICENSE.md) file for description of the license terms and OASIS policies applicable to the TC's work in this GitHub project. Content in this repository is intended to be part of the MQTT TC's permanent record of activity, visible and freely available for all to use, subject to applicable OASIS policies, as presented in the repository [LICENSE](https://github.com/oasis-tcs/MQTT/blob/master/LICENSE.md). 

## Contact

Please send questions or comments about [OASIS TC GitHub repositories](https://www.oasis-open.org/resources/tcadmin/github-repositories-for-oasis-tc-members-chartered-work) to the [OASIS TC Administrator](mailto:tc-admin@oasis-open.org).  For questions about content in this repository, please contact the TC Chair or Co-Chairs as listed on the  MQTT TC's [home page](https://www.oasis-open.org/committees/mqtt/).
