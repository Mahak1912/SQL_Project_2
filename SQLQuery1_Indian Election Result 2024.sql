--Q1.What is the total number of seats available for elections in each state?
select s1.State as State_name,count(c.Parliament_Constituency) as No_of_seats
from constituencywise_results c inner join statewise_results s 
on c.Parliament_Constituency=s.Parliament_Constituency 
inner join states s1 on s.State_ID=s1.State_ID group by s1.State

--Q2.	Total Seats Won by NDA Allianz?
select count(
case when p.Party in ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM') then c.Parliament_Constituency end) as No_of_seats_NDA_won
				from constituencywise_results c 
inner join partywise_results p on c.Party_ID=p.Party_ID

--Q3	Seats Won by NDA Allianz Parties?
select p.Party,count(
case when p.Party in ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM') then c.Parliament_Constituency end) as No_of_seats_NDA_won
from constituencywise_results c 
inner join partywise_results p on c.Party_ID=p.Party_ID group by p.Party order by No_of_seats_NDA_won desc

--Q4 Total Seats Won by I.N.D.I.A. Allianz
SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN [Won]
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    partywise_results


	--Q5.	Seats Won by I.N.D.I.A. Allianz Parties?

	SELECT 
    party,SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN [Won]
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
   partywise_results group by party order by INDIA_Total_Seats_Won desc


   --Q6	Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER?
   ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);
I.N.D.I.A Allianz
UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);
NDA Allianz
UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);
OTHER
UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;


--Q7.	Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
select p.Party_Alliance,count(c.parliament_constituency) as No_of_seats_won 
from partywise_results 
p inner join constituencywise_results c on p.Party_ID=c.Party_ID group by p.Party_Alliance


--Q8.	Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?
select c.winning_candidate,p.Party,c.Total_Votes,s.margin,s1.state,s.constituency from constituencywise_results c 
inner join partywise_results p on c.Party_ID=p.Party_ID
inner join statewise_results s on c.Parliament_Constituency=s.Parliament_Constituency
inner join states s1 on s.State_ID=s1.State_ID
where s1.state='Uttar Pradesh' and s.Constituency='Varanasi'

--Q9.	What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
select c1.candidate,c1.Party, c1.EVM_votes,c1.Postal_votes,c1.Total_Votes,c2.Constituency_Name
from
constituencywise_details c1
inner join constituencywise_results c2
on c1.Constituency_ID=c2.Constituency_ID
where c2.Constituency_Name='Bhopal'


--Q10.	Which parties won the most seats in s State, and how many seats did each party win?
select p.Party,count(c.parliament_constituency) as seats_won,s2.state from partywise_results p
inner join constituencywise_results c on p.Party_ID=c.Party_ID
inner join statewise_results s1 on c.Parliament_Constituency=s1.Parliament_Constituency
inner join states s2 on s1.State_ID=s2.State_ID 
group by p.party,s2.state
order by seats_won desc

--Q11. What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024?
select s2.state,count(
case when p.Party_Alliance='NDA' then c.parliament_constituency end) as NDA_Seats_won,
count(case when p.Party_Alliance='INDIA' then c.parliament_constituency end) as INDIA_Seats_won,
count(case when p.Party_Alliance='Others' then c.parliament_constituency end) as Others_Seats_won
from partywise_results p 
inner join constituencywise_results c on p.Party_ID=c.Party_ID
inner join statewise_results s1 on c.Parliament_Constituency=s1.Parliament_Constituency
inner join states s2 on s1.State_ID=s2.State_ID
group by s2.State


--Q12.	Which candidate received the highest number of EVM votes in each constituency (Top 10)?
select candidate,constituency_name,EVM_votes from (
select c1.candidate,c2.constituency_name,c1.EVM_votes,rank() over (order by c1.EVM_Votes desc) as rnk
from constituencywise_details c1 
inner join constituencywise_results c2 on c1.Constituency_ID=c2.Constituency_ID) A where rnk<=10


--Q13.	Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?
WITH RankedCandidates AS (
    SELECT 
        cd.Constituency_ID,
        cd.Candidate,
        cd.Party,
        cd.EVM_Votes,
        cd.Postal_Votes,
        cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
        ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
    FROM 
        constituencywise_details cd
    JOIN 
        constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
    JOIN 
        statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN 
        states s ON sr.State_ID = s.State_ID
)

SELECT 
    cr.Constituency_Name,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
    cr.Constituency_Name
ORDER BY 
    cr.Constituency_Name;

--Q14.For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), 
--and the breakdown of EVM and postal votes?
select count(distinct c2.Parliament_Constituency) as Total_Seats,count(distinct c1.candidate) as Total_candidates, count(distinct p.party) as no_of_parties,
sum(c1.Total_votes) as Total_votes,
sum(c1.EVM_votes) as Total_EVM_votes,sum(c1.Postal_votes) as Total_Postal_votes
from 
constituencywise_details c1 inner join constituencywise_results c2 on c1.Constituency_ID=c2.Constituency_ID
inner join partywise_results p on p.Party_ID=c2.Party_ID
inner join statewise_results s1 on c2.Parliament_Constituency=s1.Parliament_Constituency
inner join states s2 on s1.State_ID=s2.State_ID where s2.State='Maharashtra'



