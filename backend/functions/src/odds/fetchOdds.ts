const url = 'https://apiv2.allsportsapi.com/football?met=Odds&APIkey=41ae247ecfb3e309b4c4099599848989c3f3f2a00d28e6b3e388ac6d8ac85fa1';

import axios from 'axios';


export const fetchOdds = async () => {
    const response = await axios.get(url);
    return response.data;
}