class Handshake::Models::Person < Handshake::Models::Base
  include Handshake::Exceptions

  ATTRS = [:type, :id, :username, :first_name, :last_name, :email_address, :mobile_number]

  define_accessors(ATTRS)

  self.client = Handshake::Clients::Users.new

  def self.find_all
    response = self.client.get
    raise Handshake::Exceptions::ApiError unless response["success"]

    users = response["users"]
    users.map { |user| self.new(user) }
  end

end

  # Below are all the attributes from Handshake
  # ATTRS = [:type, :id, :username, :first_name, :last_name, :email_address, :mobile_number,
  #          :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at, :institution_id, :institution_type,
  #          :is_confirmed, :bio, :start_progress, :school_year_id, :progress, :work_authorization_id, :user_type,
  #          :work_study_eligible, :document_review_status, :profile_review_status, :is_public, :office_phone_number,
  #          :disabled, :time_zone, :status, :is_contact, :calendar_token, :override_disabled_field, :profile_or_document_submit_time,
  #          :last_logged_in, :title, :third_party_recruiter, :hidden_navigation_columns, :ethnicity, :middle_name, :preferred_name,
  #          :hidden_fields, :assigned_to_id, :campus_id, :auth_identifier, :requires_us_sponsorship, :opt_cpt_eligible,
  #          :self_reported_graduation_date, :suspended, :all_major_ids, :all_major_names, :name, :institution_name, :institution_logo_url,
  #          :user_photo_url, :entity_path, :school_year_name, :organization_ids, :institution_id_type, :added_institution_label_ids,
  #          :mentor_information_id, :mentor_information_user_id, :mentor_information_student_contact_preference, :mentor_information_maximum_mentees,
  #          :mentor_information_advice, :mentor_information_expertise_ids, :mentor_information_hobbies, :mentor_information_industry_id,
  #          :mentor_information_industry_name, :employer_ids, :job_function_ids, :job_titles, :newsgroup_ids, :skill_names, :organization_names,
  #          :extra_curricular_names, :extra_curricular_positions, :extra_curricular_descriptions, :project_descriptions, :project_position_names,
  #          :project_names, :course_names, :course_codes, :education_school_names, :work_authorization_name, :work_experience_job_function_names,
  #          :work_experience_employer_names, :work_experience_descriptions, :moment_time_zone, :appointment_type_ids, :role_names, :goal_option_ids,
  #          :post_graduation_option_ids, :interested_industry_ids, :interested_industry_category_ids, :interested_job_function_ids, :interested_region_names,
  #          :interested_location_points, :interested_states, :interested_countries, :custom_job_interest_option_ids, :graduate_program_option_ids, :primary_education]
