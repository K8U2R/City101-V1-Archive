resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

files {
  'audioconfig/nfsv8_game.dat151.rel',
  'audioconfig/nfsv8_sounds.dat54.rel',
  'sfx/dlc_nfsv8/nfsv8.awc',
  'sfx/dlc_nfsv8/nfsv8_npc.awc'
}

data_file 'AUDIO_GAMEDATA' 'audioconfig/nfsv8_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/nfsv8_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_nfsv8'


client_script {
    'vehicle_names.lua'
}