const abi = [
    {
        "inputs": [],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "address",
                "name": "_from",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "_ong",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "_amount",
                "type": "uint256"
            }
        ],
        "name": "DonationEvent",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "timestamp",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "_ong",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "_amount",
                "type": "uint256"
            }
        ],
        "name": "WithdrawalEvent",
        "type": "event"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "categories",
        "outputs": [
            {
                "internalType": "string",
                "name": "name",
                "type": "string"
            },
            {
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "qty",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "components": [
                    {
                        "internalType": "uint8",
                        "name": "q1",
                        "type": "uint8"
                    },
                    {
                        "internalType": "uint8",
                        "name": "q2",
                        "type": "uint8"
                    },
                    {
                        "internalType": "uint8",
                        "name": "q3",
                        "type": "uint8"
                    },
                    {
                        "internalType": "uint8",
                        "name": "q4",
                        "type": "uint8"
                    },
                    {
                        "internalType": "uint8",
                        "name": "q5",
                        "type": "uint8"
                    }
                ],
                "internalType": "struct EquiGive.Questionnaire",
                "name": "_questionnaire",
                "type": "tuple"
            },
            {
                "internalType": "uint32",
                "name": "_category",
                "type": "uint32"
            },
            {
                "internalType": "uint32",
                "name": "_region",
                "type": "uint32"
            }
        ],
        "name": "donate",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getCategories",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "string",
                        "name": "name",
                        "type": "string"
                    },
                    {
                        "internalType": "uint256",
                        "name": "amount",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "qty",
                        "type": "uint256"
                    }
                ],
                "internalType": "struct EquiGive.Category[]",
                "name": "",
                "type": "tuple[]"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint32",
                "name": "_category",
                "type": "uint32"
            },
            {
                "internalType": "uint32",
                "name": "_region",
                "type": "uint32"
            }
        ],
        "name": "getONGsByFilter",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "uint256",
                        "name": "id",
                        "type": "uint256"
                    },
                    {
                        "internalType": "string",
                        "name": "logo",
                        "type": "string"
                    },
                    {
                        "internalType": "string",
                        "name": "name",
                        "type": "string"
                    },
                    {
                        "internalType": "uint32",
                        "name": "category",
                        "type": "uint32"
                    },
                    {
                        "internalType": "uint32",
                        "name": "region",
                        "type": "uint32"
                    },
                    {
                        "internalType": "uint256",
                        "name": "amount",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "withdrawn",
                        "type": "uint256"
                    },
                    {
                        "components": [
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            },
                            {
                                "internalType": "uint256",
                                "name": "timestamp",
                                "type": "uint256"
                            }
                        ],
                        "internalType": "struct EquiGive.Withdrawal[]",
                        "name": "withdrawals",
                        "type": "tuple[]"
                    },
                    {
                        "internalType": "address",
                        "name": "owner",
                        "type": "address"
                    },
                    {
                        "internalType": "uint256",
                        "name": "qty",
                        "type": "uint256"
                    },
                    {
                        "internalType": "address payable",
                        "name": "donationsWallet",
                        "type": "address"
                    },
                    {
                        "components": [
                            {
                                "internalType": "uint8",
                                "name": "q1",
                                "type": "uint8"
                            },
                            {
                                "internalType": "uint8",
                                "name": "q2",
                                "type": "uint8"
                            },
                            {
                                "internalType": "uint8",
                                "name": "q3",
                                "type": "uint8"
                            },
                            {
                                "internalType": "uint8",
                                "name": "q4",
                                "type": "uint8"
                            },
                            {
                                "internalType": "uint8",
                                "name": "q5",
                                "type": "uint8"
                            }
                        ],
                        "internalType": "struct EquiGive.Questionnaire",
                        "name": "questionnaire",
                        "type": "tuple"
                    }
                ],
                "internalType": "struct EquiGive.Ong[]",
                "name": "",
                "type": "tuple[]"
            },
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getOwner",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getRegions",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "string",
                        "name": "name",
                        "type": "string"
                    },
                    {
                        "internalType": "uint256",
                        "name": "amount",
                        "type": "uint256"
                    },
                    {
                        "internalType": "uint256",
                        "name": "qty",
                        "type": "uint256"
                    }
                ],
                "internalType": "struct EquiGive.Region[]",
                "name": "",
                "type": "tuple[]"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_user",
                "type": "address"
            },
            {
                "internalType": "uint256",
                "name": "_index",
                "type": "uint256"
            }
        ],
        "name": "getUserDonationPackages",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "uint256",
                        "name": "id",
                        "type": "uint256"
                    },
                    {
                        "components": [
                            {
                                "internalType": "uint256",
                                "name": "ong",
                                "type": "uint256"
                            },
                            {
                                "internalType": "uint256",
                                "name": "amount",
                                "type": "uint256"
                            }
                        ],
                        "internalType": "struct EquiGive.Donation[]",
                        "name": "donations",
                        "type": "tuple[]"
                    }
                ],
                "internalType": "struct EquiGive.DonationPackage",
                "name": "",
                "type": "tuple"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_user",
                "type": "address"
            }
        ],
        "name": "getUserDonationsCount",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_user",
                "type": "address"
            }
        ],
        "name": "getUserDonationsPackagesCount",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "ong",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "id",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "logo",
                "type": "string"
            },
            {
                "internalType": "string",
                "name": "name",
                "type": "string"
            },
            {
                "internalType": "uint32",
                "name": "category",
                "type": "uint32"
            },
            {
                "internalType": "uint32",
                "name": "region",
                "type": "uint32"
            },
            {
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "withdrawn",
                "type": "uint256"
            },
            {
                "internalType": "address",
                "name": "owner",
                "type": "address"
            },
            {
                "internalType": "uint256",
                "name": "qty",
                "type": "uint256"
            },
            {
                "internalType": "address payable",
                "name": "donationsWallet",
                "type": "address"
            },
            {
                "components": [
                    {
                        "internalType": "uint8",
                        "name": "q1",
                        "type": "uint8"
                    },
                    {
                        "internalType": "uint8",
                        "name": "q2",
                        "type": "uint8"
                    },
                    {
                        "internalType": "uint8",
                        "name": "q3",
                        "type": "uint8"
                    },
                    {
                        "internalType": "uint8",
                        "name": "q4",
                        "type": "uint8"
                    },
                    {
                        "internalType": "uint8",
                        "name": "q5",
                        "type": "uint8"
                    }
                ],
                "internalType": "struct EquiGive.Questionnaire",
                "name": "questionnaire",
                "type": "tuple"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "regions",
        "outputs": [
            {
                "internalType": "string",
                "name": "name",
                "type": "string"
            },
            {
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "qty",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            },
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "userDonations",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "ong",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "name": "userQuestionnaires",
        "outputs": [
            {
                "internalType": "uint8",
                "name": "q1",
                "type": "uint8"
            },
            {
                "internalType": "uint8",
                "name": "q2",
                "type": "uint8"
            },
            {
                "internalType": "uint8",
                "name": "q3",
                "type": "uint8"
            },
            {
                "internalType": "uint8",
                "name": "q4",
                "type": "uint8"
            },
            {
                "internalType": "uint8",
                "name": "q5",
                "type": "uint8"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "_amount",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "_ongId",
                "type": "uint256"
            }
        ],
        "name": "withdraw",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    }
];


let w3 = null;
let account = null;
let questionnaire = null;
let categoriaid = null;
let regionid = null;

addEventListener("load", (event) => {

    if (typeof window.ethereum !== 'undefined') {

        console.log('MetaMask is installed!');
        //Connect to MetaMask
        ethereum.request({ method: 'eth_requestAccounts' })
            .then((accounts) => {
                account = accounts[0];
                document.getElementById("btnConnect").innerHTML = account.substring(0, 6) + '...' + account.substring(account.length - 4);
                w3 = new Web3(ethereum);

                //Get the contract instance
                const contract = new w3.eth.Contract(abi, '0x5e5a8bDc54b3884FC0DdeeD077db917913EE7429');
                let dropdownRegion = document.getElementById("dropdownRegion");
                contract.methods.getRegions().call().then((result) => {
                    for (let i = 0; i < result.length; i++) {
                        dropdownRegion.innerHTML += '<a class="dropdown-item" onclick="document.getElementById(\'btnRegion\').innerHTML = \'' + result[i].name + '\'; regionid=' + i.toString() + '" href="#">' + result[i].name + '</a>';
                    }
                });
                let dropdownCategoria = document.getElementById("dropdownCategoria");
                contract.methods.getCategories().call().then((result) => {
                    for (let i = 0; i < result.length; i++) {
                        dropdownCategoria.innerHTML += '<a class="dropdown-item" onclick="document.getElementById(\'btnCategoria\').innerHTML = \'' + result[i].name + '\'; categoriaid=' + i.toString() + '" href="#">' + result[i].name + '</a>';
                    }
                })

                contract.methods.userQuestionnaires(account).call().then((result) => {
                    questionnaire = result;
                });

                document.getElementById("btnContinueForm").addEventListener("click", (event) => {
                    contract.methods.donate([questionnaire.q1, questionnaire.q2, questionnaire.q3, questionnaire.q4, questionnaire.q5], categoriaid, regionid)
                        .send({ from: account, value: w3.utils.toWei(document.getElementById('donation_amount').value) }).then((result) => {
                            window.location.href = "donation.html?donation=7";
                        }).catch((error) => {
                            alert(error)
                        });

                });



            })
            .catch((error) => {
                if (error.code === 4001) {
                    // EIP-1193 userRejectedRequest error
                    console.log('Please connect to MetaMask.');
                } else {
                    console.error(error);
                }
            });






    } else {
        console.log('MetaMask is not installed!');
    }
});

document.getElementById('btnConnect').addEventListener("click", (event) => {

    if (typeof window.ethereum !== 'undefined') {

        console.log('MetaMask is installed!');
        //Connect to MetaMask
        ethereum.request({ method: 'eth_requestAccounts' })
            .then((accounts) => {
                account = accounts[0];
                document.getElementById("btnConnect").innerHTML = account.substring(0, 6) + '...' + account.substring(account.length - 4);
                w3 = new Web3(ethereum);

                //Get the contract instance
                const contract = new w3.eth.Contract(abi, '0x5e5a8bDc54b3884FC0DdeeD077db917913EE7429');
                let dropdownRegion = document.getElementById("dropdownRegion");
                contract.methods.getRegions().call().then((result) => {
                    for (let i = 0; i < result.length; i++) {
                        dropdownRegion.innerHTML += '<a class="dropdown-item" onclick="document.getElementById(\'btnRegion\').innerHTML = \'' + result[i].name + '\'; regionid=' + i.toString() + '" href="#">' + result[i].name + '</a>';
                    }
                });
                let dropdownCategoria = document.getElementById("dropdownCategoria");
                contract.methods.getCategories().call().then((result) => {
                    for (let i = 0; i < result.length; i++) {
                        dropdownCategoria.innerHTML += '<a class="dropdown-item" onclick="document.getElementById(\'btnCategoria\').innerHTML = \'' + result[i].name + '\'; categoriaid=' + i.toString() + '" href="#">' + result[i].name + '</a>';
                    }
                })

                contract.methods.userQuestionnaires(account).call().then((result) => {
                    questionnaire = result;
                });

                document.getElementById("btnContinueForm").addEventListener("click", (event) => {
                    contract.methods.donate([questionnaire.q1, questionnaire.q2, questionnaire.q3, questionnaire.q4, questionnaire.q5], categoriaid, regionid)
                        .send({ from: account, value: w3.utils.toWei(document.getElementById('donation_amount').value) }).then((result) => {
                            window.location.href = "donation.html?donation=7";
                        }).catch((error) => {
                            alert(error)
                        });

                });



            })
            .catch((error) => {
                if (error.code === 4001) {
                    // EIP-1193 userRejectedRequest error
                    console.log('Please connect to MetaMask.');
                } else {
                    console.error(error);
                }
            });






    } else {
        console.log('MetaMask is not installed!');
    }
});