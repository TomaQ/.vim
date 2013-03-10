#!/usr/bin/env ruby

def create_symlinks(vim_files, vim_dir, home_dir)
  puts "Would you like to create symlinks to this configuration? [y/n]"
  user_input = gets.chomp.downcase

  if user_input == 'y'
    vim_files.each { |f|
      sym = "#{home_dir}/#{f}"
      orig = f != '.vim' ? "#{vim_dir}/#{f}" : "#{vim_dir}"

      # TODO: Add check to see if symlink exists and is pointing to vim_dir;
      # If not, remove old |f| and create a symlink to |f| in vim_dir.
      if File.exist? sym
        puts "Link '#{sym}' has already been created."
      else
        File.symlink("#{orig}", "#{sym}")
        puts "Created link '#{sym}' -> '#{orig}'"
      end
    }
  elsif user_input == 'n'
    puts "Your Vim configuration has not been properly linked, because of this Vim will probably not work as intended."
  else
    create_vimrc_symlink(vim_files, vim_dir, home_dir)
  end
end

VIM_FILES = ['.vimrc', '.vim']
create_symlinks(VIM_FILES, File.expand_path(File.dirname(__FILE__)), Dir.home)
