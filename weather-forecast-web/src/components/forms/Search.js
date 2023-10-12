import { useState } from "react";
import axios from 'axios'
import WeatherCard from "../weather/WeatherCard";

function Search() {
    const [address, setAddress] = useState('');
    const [zipCode, setZipCode] = useState('');
    const [showResults, setShowResults] = useState(false);
    const [weatherData, setWeatherData] = useState({});
    const [showAddress, setShowAddress] = useState(true);

    const handleOnSubmit = async (event) => {
        event.preventDefault();
        await axios.get(`${process.env.REACT_APP_API_URL}/api/v1/weather`, {
            params: {
                address: address,
                zip_code: zipCode
            }
        }).then( (response ) => {
            setShowResults(true);
            setWeatherData({...response.data.data.attributes, feelsLike: response.data.data.attributes.feels_like});
        }).catch(() => {
            console.log('handle failure');
        })
    }

    const handleAddressInputChange = (event) => {
        setAddress(event.target.value)
    }
    
    const handleZipCodeInputChange = (event) => {
        setZipCode(event.target.value)
    }

    const handleShowAddressClick = (value) => {
        if(value){
           setZipCode(''); 
        }else{
            setAddress(''); 
        }
        setShowAddress(value);
    }

    return(
        <div>
            {!showResults && <div className="mb-4 border-b border-gray-200 dark:border-gray-700">
                <ul className="flex flex-wrap justify-center -mb-px text-sm font-medium text-center">
                    <li className="mr-2">
                        <button onClick={() => handleShowAddressClick(true)} 
                        className={`inline-block p-4 border-b-4 rounded-t-lg ${showAddress ? 'border-blue-500' : 'border-transparent'}`} type="button">Address</button>
                    </li>
                    <li className="mr-2">
                        <button onClick={() => handleShowAddressClick(false)} 
                        className={`inline-block p-4 border-b-4 rounded-t-lg ${!showAddress ? 'border-blue-500' : 'border-transparent'}`} type="button">Zip Code</button>
                    </li>
                </ul>
            </div> }

            {!showResults && <div className="w-96">
                <form onSubmit={handleOnSubmit}>
                    { showAddress && <div>
                        <div className="pb-4">
                            <label className="pr-4">Address</label>
                        </div>
                        <input placeholder="Ex: 145 SW 13th ST, Miami, FL" type="text" value={address} className="border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" onChange={handleAddressInputChange}></input>
                    </div>}

                    { !showAddress && <div>
                        <div className="pb-4">
                            <label className="pr-4">Zip Code</label>
                        </div>
                        <input placeholder="33131" type="text" value={zipCode} className="border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" onChange={handleZipCodeInputChange}></input>
                    </div>}
                    
                    <div className="pt-4">
                    <button className=" w-full text-center rounded px-3 py-1.5 border border-blue-500 bg-blue-500 text-white">Submit</button>
                    </div>
                </form>
            </div>}

            {showResults && <div>
                <WeatherCard {...weatherData} />
            </div>
            }
        </div>
    )
}

export default Search;