# Cleanup old Lightroom backups

import os
import shutil
from datetime import datetime, timedelta

# Path to the backup directory
backup_directory = '/Users/mark/Pictures/Backups'

# Calculate the cutoff time (2 months ago)
cutoff_date = datetime.now() - timedelta(days=60)

def delete_old_backups(directory, cutoff_date):
    # Get the current timestamp for comparison
    cutoff_timestamp = cutoff_date.timestamp()

    # Ensure the directory exists
    if not os.path.exists(directory):
        print(f"Error: Directory '{directory}' does not exist.")
        return

    # Iterate through the files and folders in the directory
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)

        try:
            # Get the last modification time of the directory
            file_mod_time = os.path.getmtime(file_path)

            # Check if the item is a directory and is older than the cutoff date
            if os.path.isdir(file_path) and file_mod_time < cutoff_timestamp:
                # Delete the directory and its contents
                shutil.rmtree(file_path)
                print(f"Deleted Lightroom backup and its contents: {file_path}")

        except Exception as e:
            print(f"Error processing '{file_path}': {e}")

# Run the function
delete_old_backups(backup_directory, cutoff_date)