# Give-a-Hack
A Postgre SQL database co-designed with [Mahendran Mookkiah](https://github.com/mookkiah) in AWS used for a hackathon team project 8/22/25 - 8/28/25.

## Summary

[Give-a-Hack](https://www.giveahack.org/) 2025 was a first annual community hackathon in Jacksonville, FL with a charity mission: 
>Enable a thriving, connected community where every individual or organization in need can seamlessly connect with nonprofits, services, and companies willing to help—fostering resilience, compassion, and collective progress in our city.

## Schema

<details>
<summary>Organizations Table</summary>
<br/>
 
Has columns for a primary key of type UUID, a foreign key for the primary service category, and several columns for details about each organization.

<br/></details>

<details>
<summary>Service Categories Table</summary>
<br/>
 
Has columns for a primary key of type UUID, a foreign key for the name, and a description.

<br/></details>

<details>
<summary>Need Table</summary>
<br/>
 
Has columns for a primary key of type UUID, a foreign key for the identified category, and several columns for details about the post.

<br/></details>

<details>
<summary>Ticket Status Table</summary>
<br/>
 
Has columns for the need_id of type UUID, a status that is non-nullable, and for accepted_by.

<br/></details>

## Sample Data

<details>
<summary>Organizations Table</summary>
<br/>
 
A list of 15 local charities using real data.

<br/></details>

<details>
<summary>Service Categories Table</summary>
<br/>
 
A list of 7 categories as defined by the initial keyword association pre-programmed into the API source of data.

<br/></details>

<details>
<summary>Need Table</summary>
<br/>
 
100 simulated social media posts added as mock-up data for data visualization.

<br/></details>

<details>
<summary>Ticket Status Table</summary>
<br/>
 
A list of all need_id in the Needs table, with statuses and organizations assigned as mock-up data.  The statuses were assigned at random with 85 Completed, 10 Accepted, and 4 Received.  Completed and Accepted needs were then assigned an organization at random based on matching the identified category from the Needs table to the primary service category on the Organization table.

<br/></details>

## Visualization


