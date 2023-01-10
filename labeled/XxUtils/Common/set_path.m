function [Save_path] = set_path( Folder_name )
% This function recieve a folder name and return its path as sub-folder in
% current folder.If there is no such folder in current path, it will create
% one.
Current_path=pwd;
Save_path=fullfile(Current_path, Folder_name);
if ~exist(Folder_name,'dir')
    mkdir(Folder_name);
end
end

