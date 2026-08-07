IntroConfig = {}

-- Whether to play the sheriff intro cutscene or start directly in gender selection
IntroConfig.UseCutscene = true

-- Whether to use the sheriff's spoken dialog during the intro
IntroConfig.UseDialog = true

-- Whether to skip specifically the character customization dialog
IntroConfig.UseCustomizeDialog = false

-- Minimum and maximum cooldown time (in seconds) between idle fidget animations
IntroConfig.FidgetCooldownMin = 30
IntroConfig.FidgetCooldownMax = 60

-- Create outfits to randomly apply to the preset peds during the intro
IntroConfig.Outfits = {
    [EDITOR_CONFIG.MALE] = {
        { "CLOTHING_ITEM_M_UST_000_TINT_003",   "CLOTHING_ITEM_M_PANTS_000_TINT_001", "CLOTHING_ITEM_M_BOOTS_002_TINT_002", "CLOTHING_ITEM_M_SUSPENDERS_000_TINT_002", },
        { "CLOTHING_ITEM_M_PANTS_013_TINT_005", "CLOTHING_ITEM_M_SHIRT_006_TINT_001", "CLOTHING_ITEM_M_VEST_005_TINT_001",  "CLOTHING_ITEM_M_BOOTS_000_TINT_003",      "CLOTHING_ITEM_M_SUSPENDERS_000_TINT_002", },
        { "CLOTHING_ITEM_M_PANTS_002_TINT_005", "CLOTHING_ITEM_M_UST_000_TINT_005",   "CLOTHING_ITEM_M_VEST_003_TINT_002",  "CLOTHING_ITEM_M_BOOTS_002_TINT_006",      "CLOTHING_ITEM_M_SUSPENDERS_000_TINT_006", },
        { "CLOTHING_ITEM_M_VEST_004_TINT_005",  "CLOTHING_ITEM_M_PANTS_000_TINT_001", "CLOTHING_ITEM_M_SHIRT_004_TINT_003", "CLOTHING_ITEM_M_BOOTS_000_TINT_001",      "CLOTHING_ITEM_M_SPURS_001_TINT_002", },
        { "CLOTHING_ITEM_M_VEST_001_TINT_001",  "CLOTHING_ITEM_M_SHIRT_005_TINT_006", "CLOTHING_ITEM_M_PANTS_000_TINT_002", "CLOTHING_ITEM_M_BOOTS_000_TINT_005",      "CLOTHING_ITEM_M_SPURS_002_TINT_001", },
    },
    [EDITOR_CONFIG.FEMALE] = {
        { "CLOTHING_ITEM_F_CHEMISE_000_TINT_001", "CLOTHING_ITEM_F_PANTS_000_TINT_004", "CLOTHING_ITEM_F_BOOTS_002_TINT_001", "CLOTHING_ITEM_F_SUSPENDERS_000_TINT_006", },
        { "CLOTHING_ITEM_F_VEST_005_TINT_007",    "CLOTHING_ITEM_F_SHIRT_009_TINT_002", "CLOTHING_ITEM_F_PANTS_013_TINT_004", "CLOTHING_ITEM_F_BOOTS_000_TINT_002", },
        { "CLOTHING_ITEM_F_VEST_004_TINT_001",    "CLOTHING_ITEM_F_SKIRT_001_TINT_003", "CLOTHING_ITEM_F_SHIRT_001_TINT_004", "CLOTHING_ITEM_F_BOOTS_002_TINT_006", },
        { "CLOTHING_ITEM_F_VEST_003_TINT_001",    "CLOTHING_ITEM_F_SHIRT_001_TINT_005", "CLOTHING_ITEM_F_SKIRT_000_TINT_003", "CLOTHING_ITEM_F_BOOTS_001_TINT_001", },
        { "CLOTHING_ITEM_F_SHIRT_003_TINT_004",   "CLOTHING_ITEM_F_PANTS_004_TINT_003", "CLOTHING_ITEM_F_BOOTS_002_TINT_001", "CLOTHING_ITEM_F_SUSPENDERS_001_TINT_001", },
    }
}

IntroConfig.Names = {
    [EDITOR_CONFIG.MALE] = {
        "Abe", "Abraham", "Absalom", "Albert", "Algernon", "Ambrose", "Amos",
        "Anders", "Andrew", "Angus", "Anthony", "Archibald", "Archie", "Arthur",
        "Barnaby", "Bartholomew", "Baptiste", "Beau", "Benedict", "Benjamin",
        "Bernard", "Bill", "Caleb", "Calvin", "Cassius", "Cecil", "Charles",
        "Chester", "Clarence", "Clay", "Cleet", "Clement", "Colm", "Cornelius",
        "Curtis", "Darius", "David", "Duncan", "Ebenezer", "Edgar", "Edwin",
        "Elias", "Elijah", "Elmer", "Emmett", "Ephraim", "Ernest", "Ethan",
        "Ezekiel", "Ezra", "Felix", "Fletcher", "Francis", "Frank", "Frederick",
        "Gabriel", "Gareth", "Gavin", "George", "Gerald", "Gideon", "Gilbert",
        "Glenn", "Godfrey", "Grover", "Hank", "Harlan", "Harold", "Harrison",
        "Harvey", "Hector", "Henry", "Hiram", "Homer", "Horace", "Hosea",
        "Howard", "Hugh", "Iain", "Ignatius", "Isaac", "Isaiah", "Jack",
        "Jacob", "Jake", "Jameson", "Jamie", "Javier", "Jeremiah", "Jerome",
        "Jesse", "Joel", "John", "Joseph", "Josiah", "Julian", "Kieran",
        "Lafayette", "Lawrence", "Leander", "Lemuel", "Lenny", "Leon", "Lester",
        "Levi", "Lucas", "Lucius", "Luther", "Malcolm", "Marshall", "Martin",
        "Matthew", "Maurice", "Maxim", "Micah", "Montgomery", "Mortimer",
        "Moses", "Nate", "Nathaniel", "Ned", "Nelson", "Nicholas", "Obediah",
        "Oliver", "Orville", "Oscar", "Oswald", "Otis", "Owen", "Patrick",
        "Percival", "Peter", "Philip", "Phineas", "Preston", "Ralph", "Raymond",
        "Reardon", "Reuben", "Richard", "Robert", "Roderick", "Roscoe", "Rufus",
        "Russell", "Samson", "Samuel", "Sean", "Sergio", "Seth", "Silas",
        "Solomon", "Spencer", "Stanley", "Stephen", "Terrence", "Thaddeus",
        "Thomas", "Tobias", "Tobin", "Ulysses", "Victor", "Virgil", "Walter",
        "Warren", "Wesley", "Wilbur", "William", "Willis", "Wyatt", "Zachariah"
    },
    [EDITOR_CONFIG.FEMALE] = {
        "Abigail", "Ada", "Adeline", "Agnes", "Alice", "Allison", "Alma",
        "Amelia", "Annabelle", "Augusta", "Barbarella", "Beatrice", "Belle",
        "Bertha", "Bessie", "Blanche", "Bonnie", "Calamity", "Camilla",
        "Carmela", "Caroline", "Catherine", "Charlotte", "Clara", "Clementine",
        "Cora", "Daisy", "Deborah", "Della", "Delilah", "Dolly", "Doris",
        "Dorothea", "Edith", "Eleanor", "Eliza", "Elizabeth", "Ella", "Ellie",
        "Elsie", "Emily", "Emma", "Esther", "Etta", "Evangeline", "Evelyn",
        "Faith", "Fanny", "Flora", "Florence", "Georgia", "Gertrude", "Gladys",
        "Grace", "Hannah", "Harriet", "Hattie", "Hazel", "Helen", "Henrietta",
        "Hester", "Ida", "Inez", "Irene", "Iris", "Isabel", "Jane", "Jessica",
        "Josephine", "Judith", "Julia", "June", "Karen", "Katherine", "Laura",
        "Lavinia", "Lena", "Lillian", "Lilly", "Lucretia", "Lucy", "Luella",
        "Lydia", "Mabel", "Maddy", "Mae", "Maeve", "Margaret", "Marian",
        "Marjorie", "Martha", "Mary", "Mathilda", "Maude", "Mercy", "Mildred",
        "Minnie", "Moira", "Molly", "Myrtle", "Nancy", "Nellie", "Nora",
        "Olive", "Ophelia", "Pearl", "Penelope", "Prudence", "Rachel", "Rose",
        "Rosemary", "Ruby", "Ruth", "Sadie", "Sarah", "Siobhan", "Sophia",
        "Susan", "Tammy", "Tess", "Thelma", "Tilly", "Vera", "Violet",
        "Virginia", "Winifred", "Zelda"
    },
    surnames = {
        "Abbott", "Adler", "Aldridge", "Anderson", "Armstrong", "Arnsdale",
        "Ashton", "Baker", "Bell", "Blackwood", "Bradley", "Braithwaite",
        "Bronte", "Buchanan", "Bullard", "Calloway", "Campbell", "Cassidy",
        "Cavanaugh", "Chambers", "Colter", "Cornwall", "Crawford", "Cross",
        "Dalton", "Danbury", "Davenport", "Dawson", "De Millemont", "Dixon",
        "Downes", "Dragic", "Dubois", "Eastep", "Ellis", "Escuella", "Evans",
        "Fairchild", "Ferguson", "Finley", "Fletcher", "Foster", "Gallagher",
        "Garrett", "Geddes", "Gibson", "Gillis", "Granger", "Graves", "Gray",
        "Griffin", "Hall", "Hamilton", "Harper", "Hawksbill", "Hayes",
        "Henderson", "Hernandez", "Hixon", "Hoare", "Holloway", "Howard",
        "Irons", "Jackson", "Jenkins", "Jennings", "Johnson", "Kearney",
        "Kelly", "King", "Lancaster", "Langton", "Lawson", "Levin",
        "Livingston", "Logan", "Lynch", "MacFarlane", "Marston", "Masterson",
        "Matthews", "McDaniels", "Mercer", "Midnight", "Miller", "Milton",
        "Montgomery", "Morgan", "O'Connor", "O'Driscoll", "O'Leary", "O'Malley",
        "O'Shea", "Palmer", "Patterson", "Pemberton", "Pinkerton", "Prescott",
        "Ramsay", "Reid", "Remington", "Reynolds", "Ricketts", "Robertson",
        "Ross", "Sawyer", "Shaw", "Shepherd", "Sinclair", "Slattery", "Smith",
        "Sullivan", "Swanson", "Tanner", "Taylor", "Thorne", "Timmins",
        "Townsend", "Trelawny", "Vance", "Van Der Linde", "Walker", "Walsh",
        "Ward", "Weathers", "West", "Wheeler", "White", "Williamson", "Wright",
        "Young", "Zizendorf"
    }
}

-- Add timecycle modifiers to pick between in the Character Creator settings menu
IntroConfig.TimecycleModifiers = {
    { label = "Default",         value = "Online_Character_Editor" },
    { label = "Wardrobe",        value = "rho_fenceshop_int", },
    { label = "Cold Cave",       value = "Bea_Cave", },
    { label = "Bright Store",    value = "val_genstore_int", },
    { label = "Harsh",           value = "hea_tunnel_01", },
    { label = "Warm Interior",   value = "val_hotel_int", },
    { label = "Photo Studio",    value = "bla_photo_int", },
    { label = "Overcast Day",    value = "exposureCurveDebugMod", },
    { label = "Sunny Day",       value = "newDeadeyeBase", },
    { label = "Spotlight",       value = "dreams_coyote_final", },
    { label = "Cold Day",        value = "dreams_deer_strawberry_updated", },
    { label = "Sunset",          value = "guama2_sunPosExt_6", },
    { label = "Direct",          value = "Gang_1_mod", },
    { label = "Cold Interior",   value = "finale1_outroHighhon_bidging1", },
    { label = "Bright Interior", value = "TRAILER2_shot37", },
    { label = "Washed Out",      value = "DeathFailClarity", },
    { label = "Dark Gray",       value = "PedKill", },
    { label = "Noon",            value = "EagleEyeBase", },
    { label = "Scenic",          value = "int_extlight_none_dark", },
}
