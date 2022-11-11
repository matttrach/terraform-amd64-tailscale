package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"os"
	"testing"
)

// this test has a description
func TestBasic(t *testing.T) {
	t.Parallel()

	var my_ssh_key string = os.Getenv("PUBLIC_SSH_KEY")

	var tfvars = map[string]interface{}{
		"ssh_key": my_ssh_key,
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/basic",
		Vars:         tfvars,
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
