# Create folders for files that are going to be organized
$folders = @('music', 'videos', 'images', 'documents', 'applications', 'archives', 'system_files', 'fonts', 'torrents', 'iso_images', 'other_shit', 'brown_logs')
foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -Path $folder -ItemType Directory
    }
}

# Function to move files in bulk using Get-ChildItem and Move-Item
function Move-Files {
    param (
        [string[]]$extensions,
        [string]$destination
    )
    Get-ChildItem -Path . -File | Where-Object { $_.Extension -in $extensions } | ForEach-Object { 
        Move-Item $_.FullName -Destination $destination -Force
    }
}

# Move all music encoding types to the music/ folder
Move-Files @('.flac', '.mp3', '.wav', '.aac', '.ogg', '.m4a', '.alac', '.wma', '.aiff') "music"

# Move all video formats to the videos/ directory
Move-Files @('.mp4', '.avi', '.mov', '.mkv', '.wmv', '.flv', '.webm', '.mpeg', '.mpg', '.3gp', '.vob') "videos"

# Move all image file types to the images/ directory
Move-Files @('.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff', '.webp', '.svg', '.ico', '.heic', '.raw', '.psd') "images"

# Move all document file types to the documents/ directory
Move-Files @('.pdf', '.doc', '.docx', '.xls', '.xlsx', '.ppt', '.pptx', '.odt', '.odp', '.ods', '.rtf', '.txt', '.csv', '.html', '.htm', '.epub', '.md') "documents"

# Move all applications and scripts to the applications/ folder
Move-Files @('.exe', '.app', '.sh', '.bat', '.py', '.js', '.jar', '.rpm', '.deb', '.pl', '.vbs', '.cgi') "applications"

# Move all archive file types to the archives/ directory
Move-Files @('.zip', '.rar', '.7z', '.tar', '.gz', '.bz2', '.xz', '.iso', '.dmg') "archives"

# Move all system/configuration file types to the system_files/ folder
Move-Files @('.ini', '.conf', '.cfg', '.plist', '.sql', '.db', '.mdb', '.bak') "system_files"

# Move all font files to the fonts/ directory
Move-Files @('.ttf', '.otf', '.woff', '.woff2') "fonts"

# Move all torrent files to the torrents/ directory
Move-Files @('.torrent') "torrents"

# Move all ISO images to the iso_images/ directory
Move-Files @('.iso') "iso_images"

# Move all log files to the brown_logs/ directory
Move-Files @('.log') "brown_logs"

# Move remaining files to the other_shit/ directory to deal with later ;)
Get-ChildItem -File | ForEach-Object {
    Move-Item $_.FullName -Destination "other_shit" -Force
}

