import { useState } from "react";
import axios from 'axios'
import WeatherCard from "../weather/WeatherCard";

function Search() {
    const [address, setAddress] = useState('');
    const [zipCode, setZipCode] = useState('');
    const [showResults, setShowResults] = useState(false);
    const [weatherData, setWeatherData] = useState({});
    const [showAddress, setShowAddress] = useState(true);
    const [showError, setShowError] = useState(false);

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
            setShowError(true);
        })
    }
    const handleErrorCloseClick = () => {
        setShowError(false);
    }

    const handleAddressInputChange = (event) => {
        setAddress(event.target.value);
        setShowError(false);
    }
    
    const handleZipCodeInputChange = (event) => {
        setZipCode(event.target.value);
        setShowError(false);
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
            {!showResults && showError &&
            <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                <strong className="font-bold">Error! </strong>
                <span className="block sm:inline">Please check your info.</span>
                <span className="absolute top-0 bottom-0 right-0 px-4 py-3" onClick={handleErrorCloseClick}>
                <svg className="fill-current h-6 w-6 text-red-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/></svg>
                </span>
            </div>
            }
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