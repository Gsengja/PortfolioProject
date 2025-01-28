select * 
from PortfolioProject..CovidDeaths

select* 
from PortfolioProject..CovidVaccinations

--Looking at Population Vs Total cases
-- Show what percentage of population got covid 

select location,date, Population,total_cases,(total_cases/population)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2,5

-- Looking at countries with highest infection Rate compare to Population
select location, date,Population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
where location like '%states%'
Group by location,population
Order by PercentPopulationInfected desc


select location, Population,MAX(total_cases) as HighestInfection,MAX(total_cases/population)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%states%'
Group by location,population
order by DeathPercentage desc

select * from PortfolioProject..CovidDeaths

select location, Population, Max(total_cases) as HighestInfectionCount, Max((total_cases/Population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
group by location,population
order by PercentPopulationInfected desc

---showing countries wiht highest Death Count per Population
select location ,MAX(Total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
group by location
order by TotalDeathCount desc


------Global Numbers
select SUM(new_cases) as total_cases,SUM (cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/Sum(new_cases)*100 as Deathpercentage
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2

select * 
from PortfolioProject..CovidVaccinations


--Looking at total population Vs Vaccinations
select * 
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidDeaths vac
on dea.location= vac.location
and dea.date = vac.date

-- use CTE

With PopvsVac(continent,location,date,population,new_Vaccinations,RollingPeopleVaccinated)
as 
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations ,
sum(convert (int,vac.new_vaccinations))over (Partition by dea.location order by dea.location,dea.date)as RollingPeopleVaccinated

----,(RollingPeopleVaccinated/Population)*100

from PortfolioProject..covidDeaths dea
join PortfolioProject..covidVaccinations vac 
on dea.location = vac.location
and dea.date = vac.date

where dea.continent is not null 
--order by 2,3
)
select * ,(RollingPeopleVaccinated/Population)*100
from PopvsVac





--- Temp Table
Drop table if exists #percentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinate numeric
)
insert into #PercentPopulationVaccinated
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations ,
sum(convert (int,vac.new_vaccinations))over (Partition by dea.location order by dea.location,dea.date)as RollingPeopleVaccinated

----,(RollingPeopleVaccinated/Population)*100

from PortfolioProject..covidDeaths dea
join PortfolioProject..covidVaccinations vac 
on dea.location = vac.location
and dea.date = vac.date

--where dea.continent is not null 
--order by 2,3
select *,( RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


---Create View
Create View PercentPopulationVaccinated as 
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations ,
sum(convert (int,vac.new_vaccinations))over (Partition by dea.location order by dea.location,dea.date)as RollingPeopleVaccinated

----,(RollingPeopleVaccinated/Population)*100

from PortfolioProject..covidDeaths dea
join PortfolioProject..covidVaccinations vac 
on dea.location = vac.location
and dea.date = vac.date

--where dea.continent is not null 
--order by 2,3

select *
From PercentPopulationVaccinated



